import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:relieve_app/datamodel/user.dart';
import 'package:relieve_app/datamodel/user_check.dart';
import 'package:relieve_app/utils/common_utils.dart';

abstract class CollectionPath {
  static const String USERS = "users";
}

class FirestoreHelper {
  static FirestoreHelper instance = FirestoreHelper();

  final Firestore _fireStore = Firestore.instance;

  Future<bool> isUserExist(
      UserCheckIdentifier checkIdentifier, String value) async {
    try {
      User user = await findUserBy(checkIdentifier, value);
      return user != null;
    } catch (error) {
      debugLog(FirestoreHelper).info(error);

      // if query not allowed, return false
      return false;
    }
  }

  /// return email if found, and null if not found
  Future<User> findUserBy(
      UserCheckIdentifier checkIdentifier, String value) async {
    if (value == null || value.isEmpty)
      throw ArgumentError('value must bot empty');

    User user; // is null

    try {
      if (checkIdentifier == UserCheckIdentifier.username) {
        final data = await _fireStore
            .collection(CollectionPath.USERS)
            .where("username", isEqualTo: value)
            .snapshots()
            .first;

        user = User.fromQuerySnapshot(data);
      } else if (checkIdentifier == UserCheckIdentifier.email) {
        final data = await _fireStore
            .collection(CollectionPath.USERS)
            .where("email", isEqualTo: value)
            .snapshots()
            .first;

        user = User.fromQuerySnapshot(data);
      } else {
        throw StateError('unhandled checkIdentifier type');
      }
    } catch (error) {
      debugLog(FirestoreHelper).info(error);
    }

    return user;
  }
}
