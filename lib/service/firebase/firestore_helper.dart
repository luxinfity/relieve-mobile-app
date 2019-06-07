import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:relieve_app/datamodel/user_check.dart';

abstract class CollectionPath {
  static const String USERS = "users";
}

class FirestoreHelper {
  static FirestoreHelper instance = FirestoreHelper();

  final Firestore _fireStore = Firestore.instance;

  Future<bool> isUserExist(
      UserCheckIdentifier checkIdentifier, String value) async {
    String result = await findUserBy(checkIdentifier, value);

    return result != null && result.isNotEmpty;
  }

  /// return email if found, and null if not found
  Future<String> findUserBy(
      UserCheckIdentifier checkIdentifier, String value) async {
    if (value == null || value.isEmpty)
      throw ArgumentError('value must bot empty');

    String email = "";
    if (checkIdentifier == UserCheckIdentifier.username) {
      final data = await _fireStore
          .collection(CollectionPath.USERS)
          .where("username", isEqualTo: value)
          .snapshots()
          .first;

      email = data?.documents?.first?.data["email"];
    } else if (checkIdentifier == UserCheckIdentifier.email) {
      final data = await _fireStore
          .collection(CollectionPath.USERS)
          .where("email", isEqualTo: value)
          .snapshots()
          .first;

      email = data?.documents?.first?.data["email"];
    } else {
      throw StateError('unhandled checkIdentifier type');
    }

    return email;
  }
}
