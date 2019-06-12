import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:relieve_app/datamodel/profile.dart';
import 'package:relieve_app/datamodel/relieve_user.dart';
import 'package:relieve_app/service/base/auth_api.dart';
import 'package:relieve_app/service/firebase/firestore_helper.dart';
import 'package:relieve_app/service/google/base.dart';
import 'package:relieve_app/utils/common_utils.dart';
import 'package:relieve_app/utils/preference_utils.dart';

/// singleton
class FirebaseAuthHelper implements AuthApi {
  static final FirebaseAuthHelper _instance = FirebaseAuthHelper._internal();

  static FirebaseAuthHelper get() => _instance;
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;

  factory FirebaseAuthHelper() {
    return _instance;
  }

  FirebaseAuthHelper._internal();

  @override
  Future<bool> isUserExist(ProfileIdentifier checkIdentifier, String value) {
    return FirestoreHelper.get().isProfileExist(checkIdentifier, value);
  }

  @override
  Future<bool> login(String username, String password) async {
    final completeProfile = await FirestoreHelper.get()
        .findUserBy(ProfileIdentifier.username, username);

    if (completeProfile == null) return false;

    try {
      FirebaseUser firebaseUser =
          await _fireBaseAuth.signInWithEmailAndPassword(
              email: completeProfile.profile.email, password: password);

      final signedInUser = await FirestoreHelper.get()
          .findUserBy(ProfileIdentifier.username, username);
      PreferenceUtils.get().saveCurrentProfile(signedInUser.profile);

      return firebaseUser != null;
    } catch (error) {
      if (error is PlatformException && error.code == "ERROR_WRONG_PASSWORD") {
        debugLog(FirebaseAuthHelper).info(error);
        return false;
      } else
        throw error;
    }
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
  Future<RelieveUser> googleLoginWrap() async {
    try {
      final googleUser = await googleSignInScope.signIn();
      final authData = await googleUser.authentication;

      final isSuccess =
          await googleLogin(authData.accessToken, authData.idToken);

      if (!isSuccess) return null;

      final relieveUser = await FirestoreHelper.get()
          .findUserBy(ProfileIdentifier.email, googleUser.email);
      PreferenceUtils.get().saveCurrentProfile(relieveUser.profile);

      return relieveUser ??
          RelieveUser(
              '',
              Profile(
                email: googleUser.email,
                fullName: googleUser.displayName,
              ));
    } catch (error) {
      // sign-in failed due to any error
      debugLog(FirebaseAuthHelper).info(error);
      return null;
    }
  }

  @override
  Future<bool> logout() async {
    // handle google credential
    if (await PreferenceUtils.get().isGoogleLogin()) {
      await googleSignInScope.signOut();
    }

    await _fireBaseAuth.signOut();

    // delete all pref
    PreferenceUtils.get().clearData();

    return true;
  }

  /// if success will return email,
  /// else return null (user might already been registered before).
  @override
  Future<bool> register(Profile profile) async {
    bool isExist = await isUserExist(ProfileIdentifier.email, profile.email);
    if (profile.username != null) {
      isExist = isExist &&
          await isUserExist(ProfileIdentifier.username, profile.username);
    }
    String uid = await PreferenceUtils.get().getUid();

    if (isExist) {
      // if user exist, don't register new user
      return false;
    } else if (uid != null) {
      // if uid is not null, user already login with google.
      if (profile.email == null || profile.email.isEmpty)
        throw ArgumentError(
            'some user data is empty, recheck before calling register');
    } else {
      if (profile.email == null ||
          profile.email.isEmpty ||
          profile.password == null ||
          profile.password.isEmpty)
        throw ArgumentError(
            'some user data is empty, recheck before calling register');

      FirebaseUser firebaseUser =
          await _fireBaseAuth.createUserWithEmailAndPassword(
              email: profile.email, password: profile.password);

      uid = firebaseUser.uid;
    }

    // drop password, so not be seen on DB
    profile = profile.copyWith(password: '');
    PreferenceUtils.get().saveCurrentProfile(profile);
    return await FirestoreHelper.get().storeProfile(uid, profile);
  }
}
