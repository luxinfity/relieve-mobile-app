import 'package:firebase_auth/firebase_auth.dart';
import 'package:relieve_app/datamodel/token.dart';
import 'package:relieve_app/datamodel/user.dart';
import 'package:relieve_app/datamodel/user_check.dart';
import 'package:relieve_app/service/base/auth_api.dart';
import 'package:relieve_app/service/firebase/firestore_helper.dart';
import 'package:relieve_app/service/google/base.dart';
import 'package:relieve_app/utils/common_utils.dart';
import 'package:relieve_app/utils/preference_utils.dart' as pref;

class FirebaseAuthHelper implements AuthApi {
  static FirebaseAuthHelper instance = FirebaseAuthHelper();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<bool> isUserExist(UserCheckIdentifier checkIdentifier, String value) {
    return FirestoreHelper.instance.isUserExist(checkIdentifier, value);
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

    debugLog(FirebaseAuthHelper).info("signed in " + user.displayName);

    return true;
  }

  @override
  Future<bool> googleLoginWrap() async {
    try {
      final account = await googleSignInScope.signIn();
      final user = await account.authentication;
      debugLog(FirebaseAuthHelper).info("login success");
      return googleLogin(user.accessToken, user.idToken);
    } catch (error) {
      // sign-in failed due to
      debugLog(FirebaseAuthHelper).info(error);
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
