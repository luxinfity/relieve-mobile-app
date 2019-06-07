import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:relieve_app/datamodel/token.dart';
import 'package:relieve_app/datamodel/user.dart';
import 'package:relieve_app/datamodel/user_check.dart';
import 'package:relieve_app/service/base/auth_api.dart';
import 'package:relieve_app/service/google/base.dart';
import 'package:relieve_app/utils/common_utils.dart';
import 'package:relieve_app/utils/preference_utils.dart' as pref;

class FirebaseAuthHelper implements AuthApi {
  static FirebaseAuthHelper instance = FirebaseAuthHelper();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _fireStore = Firestore.instance;

  @override
  Future<UserCheckResponse> checkUser(
      UserCheckIdentifier checkIdentifier, String value) {
    // TODO: implement checkUser
    return null;
  }

  @override
  Future<bool> login(String username, String password) async {
//    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
//        email: email, password: password);
    return null;
  }

  @override
  Future<bool> googleLogin(String accessToken, String idToken) async {
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: accessToken,
      idToken: idToken,
    );

    final FirebaseUser user =
        await _firebaseAuth.signInWithCredential(credential);
    printIfDebug("signed in " + user.displayName);

    return null;
  }

  @override
  Future<bool> googleLoginWrap() async {
    printIfDebug("login google try");
    try {
      final account = await googleSignInScope.signIn();
      final user = await account.authentication;
      printIfDebug("login success");
      return googleLogin(user.accessToken, user.idToken);
    } catch (error) {
      // sign-in failed due to
      printIfDebug(error);
      return false;
    }
  }

  @override
  Future<bool> logout() async {
    if (await pref.isGoogleLogin()) {
      googleSignInScope.signOut();
    }

    return null;
  }

  @override
  Future<TokenResponse> register(User user) {
    // TODO: implement register
    return null;
  }
}
