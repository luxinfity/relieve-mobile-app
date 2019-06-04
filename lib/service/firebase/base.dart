import 'package:firebase_auth/firebase_auth.dart';
import 'package:relieve_app/datamodel/token.dart';
import 'package:relieve_app/datamodel/user.dart';
import 'package:relieve_app/datamodel/user_check.dart';
import 'package:relieve_app/service/api/bakau/auth_api.dart';
import 'package:relieve_app/service/google/base.dart';
import 'package:relieve_app/utils/preference_utils.dart' as pref;

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
  Future<TokenResponse> googleLogin(String accessToken, String idToken) async {
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: accessToken,
      idToken: idToken,
    );

    final FirebaseUser user =
        await _firebaseAuth.signInWithCredential(credential);
    print("signed in " + user.displayName);

    return null;
  }

  @override
  Future<TokenResponse> googleLoginWrap() async {
    final account = await googleSignInScope.signIn();
    final user = await account.authentication;
    return googleLogin(user.accessToken, user.idToken);
  }

  @override
  Future<TokenResponse> logout() async {
    if (await pref.isGoogleLogin()) {
      googleSignInScope.signOut();
    }

    return null;
  }

  @override
  Future<TokenResponse> googleLoginWrapper() {
    return null;
  }

  @override
  Future<TokenResponse> googleLogoutWrapper() {
    return null;
  }

  @override
  Future<TokenResponse> register(User user) {
    // TODO: implement register
    return null;
  }
}
