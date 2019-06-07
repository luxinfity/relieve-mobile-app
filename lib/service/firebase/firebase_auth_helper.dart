import 'package:firebase_auth/firebase_auth.dart';
import 'package:relieve_app/datamodel/token.dart';
import 'package:relieve_app/datamodel/user.dart';
import 'package:relieve_app/datamodel/user_check.dart';
import 'package:relieve_app/service/base/auth_api.dart';
import 'package:relieve_app/service/firebase/firestore_helper.dart';
import 'package:relieve_app/service/google/base.dart';
import 'package:relieve_app/utils/common_utils.dart';
import 'package:relieve_app/utils/preference_utils.dart';

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
    try {
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: accessToken,
        idToken: idToken,
      );

      final FirebaseUser user =
          await _firebaseAuth.signInWithCredential(credential);
      if (user == null) {
        return false;
      } else {
        return true;
      }
    } catch (error) {
      debugLog(FirebaseAuthHelper).info(error);
      return false;
    }
  }

  /// nullable return type: User
  @override
  Future<User> googleLoginWrap() async {
    try {
      final user = await googleSignInScope.signIn();
      final authData = await user.authentication;

      final isSuccess =
          await googleLogin(authData.accessToken, authData.idToken);

      if (isSuccess) {
        return User(
          email: user.email,
          fullName: user.displayName,
        );
      } else {
        return null;
      }
    } catch (error) {
      // sign-in failed due to any error
      debugLog(FirebaseAuthHelper).info(error);
      return null;
    }
  }

  @override
  Future<bool> logout() async {
    if (await PreferenceUtils.isGoogleLogin()) {
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
