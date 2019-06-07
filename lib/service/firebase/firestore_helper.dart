import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:relieve_app/datamodel/user_check.dart';

class FirestoreHelper {
  static FirestoreHelper instance = FirestoreHelper();

  final Firestore _fireStore = Firestore.instance;

  Future<bool> isUserExist(
      UserCheckIdentifier checkIdentifier, String value) async {
    return false;
  }
}
