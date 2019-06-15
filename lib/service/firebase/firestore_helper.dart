import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:relieve_app/datamodel/disaster.dart';
import 'package:relieve_app/datamodel/family.dart';
import 'package:relieve_app/datamodel/profile.dart';
import 'package:relieve_app/datamodel/relieve_user.dart';
import 'package:relieve_app/service/base/disaster_service.dart';
import 'package:relieve_app/service/base/profile_service.dart';
import 'package:relieve_app/utils/common_utils.dart';
import 'package:relieve_app/utils/preference_utils.dart';

abstract class CollectionPath {
  static const String PROFILES = "profiles";
  static const String PROFILE_ADDRESSES = "address";
  static const String PROFILE_FAMILIES = "families";

  static const String DISASTERS = "disasters";
  static const String DISASTER_EVENT = "events";
}

/// singleton
class FirestoreHelper implements ProfileService, DisasterService {
  static final FirestoreHelper _instance = FirestoreHelper._internal();

  static FirestoreHelper get() => _instance;

  FirestoreHelper._internal();

  final Firestore _fireStore = Firestore.instance;

  DisasterMeta disasterMeta;

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
            .collection(CollectionPath.PROFILE_ADDRESSES)
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
            .collection(CollectionPath.PROFILES)
            .document(uid)
            .collection(CollectionPath.PROFILE_FAMILIES)
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

  /// start from page 1, must access the data on order, page 1..2..3..n
  /// return null on error
  /// return empty on no more data
  @override
  Future<List<DisasterDesc>> getDisasterList(int page, int limit,
      {DisasterType typeFilter, bool resetMeta = false}) async {
    final disasterRef =
        _fireStore.collection(CollectionPath.DISASTERS).document('meta');

    if (resetMeta) disasterMeta = null;

    try {
      if (disasterMeta == null) {
        // request meta data
        final metaSnap = await disasterRef.get();
        final totalCount = metaSnap.data['total_doc'];

        disasterMeta = DisasterMeta(
          lastRetrievedDoc: null,
          totalData: totalCount,
          currentPage: 0,
        );
      }

      Query disasterQuery =
          disasterRef.collection(CollectionPath.DISASTER_EVENT).limit(limit);

      // query filter
      if (typeFilter != null) {
        disasterQuery = disasterQuery.where('type', isEqualTo: typeFilter.name);
      }

      // start pagination
      if (disasterMeta.lastRetrievedDoc != null) {
        disasterQuery =
            disasterQuery.startAfterDocument(disasterMeta.lastRetrievedDoc);
      }

      if (page > disasterMeta.currentPage + 1)
        throw StateError('accessing data not in order');

      // execute query
      if (disasterMeta.currentPage * limit < disasterMeta.totalData) {
        final doc = await disasterQuery.getDocuments();

        final lastDoc = doc.documents.last;
        disasterMeta = DisasterMeta(
            lastRetrievedDoc: lastDoc,
            totalData: disasterMeta.totalData,
            currentPage: disasterMeta.totalData + 1);

        final disasters = doc.documents
            .map((snap) => DisasterDesc.fromJson(snap.data))
            .toList();

        return disasters;
      } else {
        // empty page
        return [];
      }
    } catch (error) {
      debugLog(FirestoreHelper).info(error);
      return null;
    }
  }
}
