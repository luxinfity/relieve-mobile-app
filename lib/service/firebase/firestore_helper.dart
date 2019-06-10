import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:relieve_app/datamodel/profile.dart';
import 'package:relieve_app/datamodel/user_check.dart';
import 'package:relieve_app/utils/common_utils.dart';

abstract class CollectionPath {
  static const String USERS = "users";
  static const String ADDRESSES = "address";
}

/// singleton
class FirestoreHelper {
  static final FirestoreHelper _instance = FirestoreHelper._internal();

  static FirestoreHelper get() => _instance;
  final Firestore _fireStore = Firestore.instance;

  factory FirestoreHelper() {
    return _instance;
  }

  FirestoreHelper._internal();

  Future<bool> isUserExist(
      UserCheckIdentifier checkIdentifier, String value) async {
    try {
      Profile profile = await findProfileBy(checkIdentifier, value);
      return profile != null;
    } catch (error) {
      debugLog(FirestoreHelper).info(error);

      // if query not allowed, return false
      return false;
    }
  }

  /// save user as a document,
  /// but save address as a collection inside user document
  /// to optimize query
  Future<bool> storeUser(String uid, Profile profile) async {
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

  /// return email if found, and null if not found
  Future<Profile> findProfileBy(
      UserCheckIdentifier checkIdentifier, String value) async {
    if (value == null || value.isEmpty)
      throw ArgumentError('value must bot empty');

    Profile profile;

    try {
      if (checkIdentifier == UserCheckIdentifier.username) {
        final data = await _fireStore
            .collection(CollectionPath.USERS)
            .where("username", isEqualTo: value)
            .snapshots()
            .first;

        profile = Profile.fromQuerySnapshot(data);
      } else if (checkIdentifier == UserCheckIdentifier.email) {
        final data = await _fireStore
            .collection(CollectionPath.USERS)
            .where("email", isEqualTo: value)
            .snapshots()
            .first;

        profile = Profile.fromQuerySnapshot(data);
      } else {
        throw StateError('unhandled checkIdentifier type');
      }
    } catch (error) {
      debugLog(FirestoreHelper).info(error);
    }

    return profile;
  }
}
