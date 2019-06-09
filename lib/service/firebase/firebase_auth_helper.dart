import 'package:firebase_auth/firebase_auth.dart';
import 'package:relieve_app/datamodel/user.dart';
import 'package:relieve_app/datamodel/user_check.dart';
import 'package:relieve_app/service/base/auth_api.dart';
import 'package:relieve_app/service/firebase/firestore_helper.dart';
import 'package:relieve_app/service/google/base.dart';
import 'package:relieve_app/utils/common_utils.dart';
import 'package:relieve_app/utils/preference_utils.dart';

/// singleton
class FirebaseAuthHelper implements AuthApi {
  static final FirebaseAuthHelper instance = FirebaseAuthHelper._internal();
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;

  factory FirebaseAuthHelper() {
    return instance;
  }

  FirebaseAuthHelper._internal();


  @override
  Future<bool> isUserExist(UserCheckIdentifier checkIdentifier, String value) {
    return FirestoreHelper.instance.isUserExist(checkIdentifier, value);
  }

  @override
  Future<bool> login(String username, String password) async {
    final completeProfile = await FirestoreHelper.instance
        .findUserBy(UserCheckIdentifier.username, username);

    if (completeProfile == null) return false;

    FirebaseUser firebaseUser = await _fireBaseAuth.signInWithEmailAndPassword(
        email: completeProfile.email, password: password);

    return firebaseUser != null;
  }

  @override
  Future<bool> googleLogin(String accessToken, String idToken) async {
    try {
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: accessToken,
        idToken: idToken,
      );

      final FirebaseUser user =
          await _fireBaseAuth.signInWithCredential(credential);

      return user != null;
    } catch (error) {
      debugLog(FirebaseAuthHelper).info(error);
      return false;
    }
  }

  /// nullable return type: User
  ///
  /// null means, user might be never register before
  /// or haven't complete registration flow
  @override
  Future<User> googleLoginWrap() async {
    try {
      final user = await googleSignInScope.signIn();
      final authData = await user.authentication;

      final isSuccess =
          await googleLogin(authData.accessToken, authData.idToken);

      if (!isSuccess) return null;

      final completeProfile = await FirestoreHelper.instance
          .findUserBy(UserCheckIdentifier.email, user.email);

      return completeProfile ??
          User(email: user.email, fullName: user.displayName);
    } catch (error) {
      // sign-in failed due to any error
      debugLog(FirebaseAuthHelper).info(error);
      return null;
    }
  }

  @override
  Future<bool> logout() async {
    // handle google credential
    if (await PreferenceUtils.isGoogleLogin()) {
      await googleSignInScope.signOut();
    }

    await _fireBaseAuth.signOut();

    // delete pref username
    PreferenceUtils.clearData();

    return true;
  }

  /// if success will return email,
  /// else return null (user might already been registered before).
  @override
  Future<bool> register(User user) async {
    bool isExist = await isUserExist(UserCheckIdentifier.email, user.email);
    String uid = await PreferenceUtils.uid();

    if (isExist) {
      // if user exist, don't register new user
      return false;
    } else if (uid != null) {
      // if uid is not null, user already login with google.
      if (user.email == null || user.email.isEmpty)
        throw ArgumentError(
            'some user data is empty, recheck before calling register');
    } else {
      if (user.email == null ||
          user.email.isEmpty ||
          user.password == null ||
          user.password.isEmpty)
        throw ArgumentError(
            'some user data is empty, recheck before calling register');

      FirebaseUser firebaseUser =
          await _fireBaseAuth.createUserWithEmailAndPassword(
              email: user.email, password: user.password);

      uid = firebaseUser.uid;
    }

    // drop password, so not be seen on DB
    user = user.copyWith(password: '');
    await FirestoreHelper.instance.storeUser(uid, user);
    return true;
  }
}
