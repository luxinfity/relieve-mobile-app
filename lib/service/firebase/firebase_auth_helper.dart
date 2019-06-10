import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:relieve_app/datamodel/profile.dart';
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
        .findProfileBy(UserCheckIdentifier.username, username);

    if (completeProfile == null) return false;

    try {
      FirebaseUser firebaseUser =
          await _fireBaseAuth.signInWithEmailAndPassword(
              email: completeProfile.email, password: password);

      final signedInUser = await FirestoreHelper.instance
          .findProfileBy(UserCheckIdentifier.username, username);
      PreferenceUtils.get().saveCurrentProfile(signedInUser);

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
  Future<Profile> googleLoginWrap() async {
    try {
      final user = await googleSignInScope.signIn();
      final authData = await user.authentication;

      final isSuccess =
          await googleLogin(authData.accessToken, authData.idToken);

      if (!isSuccess) return null;

      final completeProfile = await FirestoreHelper.instance
          .findProfileBy(UserCheckIdentifier.email, user.email);
      PreferenceUtils.get().saveCurrentProfile(completeProfile);

      return completeProfile ??
          Profile(email: user.email, fullName: user.displayName);
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
    bool isExist = await isUserExist(UserCheckIdentifier.email, profile.email);
    if (profile.username != null) {
      isExist = isExist &&
          await isUserExist(UserCheckIdentifier.username, profile.username);
    }
    String uid = await PreferenceUtils.get().uid();

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
    return await FirestoreHelper.instance.storeUser(uid, profile);
  }
}
