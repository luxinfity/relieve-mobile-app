import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:relieve_app/datamodel/family.dart';
import 'package:relieve_app/datamodel/profile.dart';
import 'package:relieve_app/datamodel/relieve_user.dart';
import 'package:relieve_app/service/base/profile_service.dart';
import 'package:relieve_app/utils/common_utils.dart';
import 'package:relieve_app/utils/preference_utils.dart';

abstract class CollectionPath {
  static const String PROFILES = "profiles";
  static const String ADDRESSES = "address";
  static const String FAMILIES = "families";
}

/// singleton
class FirestoreHelper implements ProfileService {
  static final FirestoreHelper _instance = FirestoreHelper._internal();

  static FirestoreHelper get() => _instance;
  final Firestore _fireStore = Firestore.instance;

  factory FirestoreHelper() {
    return _instance;
  }

  FirestoreHelper._internal();

  /// save user as a document,
  /// but save address as a collection inside user document
  /// to optimize query
  Future<bool> storeProfile(String uid, Profile profile) async {
    try {
      await _fireStore
          .collection(CollectionPath.PROFILES)
          .document(uid)
          .setData(profile.toMap());

      final addresses = profile.addressesToListMap();
      for (Map<String, dynamic> address in addresses) {
        await _fireStore
            .collection(CollectionPath.PROFILES)
            .document(uid)
            .collection(CollectionPath.ADDRESSES)
            .add(address);
      }

      return true;
    } catch (error) {
      debugLog(FirestoreHelper).info(error);
      return false;
    }
  }

  Future<bool> isProfileExist(
      ProfileIdentifier checkIdentifier, String value) async {
    RelieveUser profile = await findUserBy(checkIdentifier, value);
    return profile != null;
  }

  /// return `RelieveUser` if found, and null if not found
  Future<RelieveUser> findUserBy(
      ProfileIdentifier profileIdentifier, String value) async {
    if (value == null || value.isEmpty)
      throw ArgumentError('value must bot empty');

    DocumentSnapshot document;
    try {
      if (profileIdentifier == ProfileIdentifier.uid) {
        document = await _fireStore
            .collection(CollectionPath.PROFILES)
            .document(value)
            .get();
      } else if (profileIdentifier == ProfileIdentifier.username) {
        final snapshot = await _fireStore
            .collection(CollectionPath.PROFILES)
            .where("username", isEqualTo: value)
            .getDocuments();

        document = snapshot?.documents?.first;
      } else if (profileIdentifier == ProfileIdentifier.email) {
        final snapshot = await _fireStore
            .collection(CollectionPath.PROFILES)
            .where("email", isEqualTo: value)
            .getDocuments();

        document = snapshot?.documents?.first;
      } else {
        throw StateError('unhandled checkIdentifier type');
      }
    } catch (error) {
      debugLog(FirestoreHelper).info(error);
    }

    if (document == null) {
      return null;
    } else {
      return RelieveUser(document.documentID, Profile.fromMap(document.data));
    }
  }

  /// un efficient query,
  /// do chaining queries to get families profile
  /// TODO: replace with custom backend implementation
  Future<List<Family>> getFamilies() async {
    final uid = await PreferenceUtils.get().getUid();
    if (uid == null) return throw StateError('User is not logged in');

    final famDocuments = (await _fireStore
            .collection(CollectionPath.FAMILIES)
            .document(uid)
            .collection(CollectionPath.PROFILES)
            .getDocuments())
        .documents;

    List<Family> families = [];
    for (var famDocument in famDocuments) {
      final userDocument = await _fireStore
          .collection(CollectionPath.PROFILES)
          .document(famDocument.documentID)
          .get();

      if (userDocument == null) {
        // don't raise exception, try to parse next data
        debugLog(FirestoreHelper).info(StateError('''
            Family data is not exist or already deleted
            but current user not getting update
            '''));

        // skip process to next data
        continue;
      }

      final profile = Profile.fromMap(userDocument.data);
      final fam = Family(
          uid: famDocument.documentID,
          profile: profile,
          label: famDocument.data['label'] ?? '');

      families.add(fam);
    }

    return families;
  }
}
