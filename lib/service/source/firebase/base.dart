import 'package:firebase_auth/firebase_auth.dart';
import 'package:relieve_app/service/model/token.dart';
import 'package:relieve_app/service/model/user.dart';
import 'package:relieve_app/service/model/user_check.dart';
import 'package:relieve_app/service/source/api/bakau/auth_api.dart';

class Firebase implements AuthApi {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserCheckResponse> checkUser(
      UserCheckIdentifier checkIdentifier, String value) {
    // TODO: implement checkUser
    return null;
  }

  @override
  Future<TokenResponse> login(String username, String password) async {
//    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
//        email: email, password: password);
    return null;
  }

  @override
  Future<TokenResponse> register(User user) {
    // TODO: implement register
    return null;
  }
}
