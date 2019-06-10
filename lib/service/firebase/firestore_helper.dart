import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:relieve_app/datamodel/family.dart';
import 'package:relieve_app/datamodel/profile.dart';
import 'package:relieve_app/datamodel/relieve_user.dart';
import 'package:relieve_app/service/base/family_api.dart';
import 'package:relieve_app/service/base/profile_api.dart';
import 'package:relieve_app/utils/common_utils.dart';

abstract class CollectionPath {
  static const String USERS = "users";
  static const String ADDRESSES = "address";
}

/// singleton
class FirestoreHelper implements ProfileApi, FamilyApi {
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
          .collection(CollectionPath.USERS)
          .document(uid)
          .setData(profile.toMap());

      final addresses = profile.addressesToListMap();
      for (Map<String, dynamic> address in addresses) {
        await _fireStore
            .collection(CollectionPath.USERS)
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

  /// return email if found, and null if not found
  Future<RelieveUser> findUserBy(
      ProfileIdentifier checkIdentifier, String value) async {
    if (value == null || value.isEmpty)
      throw ArgumentError('value must bot empty');

    RelieveUser user;

    try {
      if (checkIdentifier == ProfileIdentifier.uid) {
        final document = await _fireStore
            .collection(CollectionPath.USERS)
            .document(value)
            .snapshots()
            .first;

        user = RelieveUser(document.documentID, Profile.fromMap(document.data));
      } else if (checkIdentifier == ProfileIdentifier.username) {
        final snapshot = (await _fireStore
            .collection(CollectionPath.USERS)
            .where("username", isEqualTo: value)
            .snapshots()
            .first);

        final document = snapshot.documents.first;
        user = RelieveUser(document.documentID, Profile.fromMap(document.data));
      } else if (checkIdentifier == ProfileIdentifier.email) {
        final snapshot = await _fireStore
            .collection(CollectionPath.USERS)
            .where("email", isEqualTo: value)
            .snapshots()
            .first;

        final document = snapshot.documents.first;
        user = RelieveUser(document.documentID, Profile.fromMap(document.data));
      } else {
        throw StateError('unhandled checkIdentifier type');
      }
    } catch (error) {
      debugLog(FirestoreHelper).info(error);
    }

    return user;
  }

  @override
  Future<List<Family>> getFamilies() async {
    return [];
  }

  @override
  Future<bool> addFamily(RelieveUser other) async {
    return false;
  }

  @override
  Future<bool> confirmFamilyAuth(String code) async {
    return false;
  }
}
