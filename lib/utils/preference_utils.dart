import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:relieve_app/datamodel/gender.dart';
import 'package:relieve_app/datamodel/profile.dart';
import 'package:relieve_app/utils/common_utils.dart';

class PreferenceUtils {
  static final PreferenceUtils _instance = PreferenceUtils._internal();

  static PreferenceUtils get() => _instance;

  PreferenceUtils._internal();

  factory PreferenceUtils() {
    return _instance;
  }

  final storage = FlutterSecureStorage();

  /// instance of user profile
  /// password and addresses will always null
  /// TODO: load address on load
  Profile currentUserProfile;

  /// Clear all pref on user phone.
  /// don't forget to call this method on logout action
  void clearData() {
    // clear profile instance
    currentUserProfile = null;

    storage.deleteAll();
  }

  Future<String> getUid() async {
    if (await isLogin() || await isGoogleLogin()) {
      final user = await FirebaseAuth.instance.currentUser();
      return user.uid;
    } else {
      return null;
    }
  }

  Future<String> getIdToken() async {
    if (await isLogin() || await isGoogleLogin()) {
      final user = await FirebaseAuth.instance.currentUser();
      return user.getIdToken();
    } else {
      return null;
    }
  }

  Future<bool> isLogin() async {
    if (currentUserProfile != null) return true;

    final user = await FirebaseAuth.instance.currentUser();
    if (user == null) return false;

    return await _loadCurrentProfile() == null;
  }

  Future<bool> isGoogleLogin() async {
    final user = await FirebaseAuth.instance.currentUser();
    if (user == null) return false;

    for (UserInfo info in user.providerData) {
      debugLog(PreferenceUtils).info(info.providerId);
      if (info.providerId == "google.com") return true;
    }

    return false;
  }

  /// profile's address will be dropped, not handled yet
  void saveCurrentProfile(Profile profile) async {
    currentUserProfile = profile;
    await storage.write(key: "username", value: profile?.username);
    await storage.write(key: "fullName", value: profile?.fullName);
    await storage.write(key: "email", value: profile?.email);
    await storage.write(key: "phone", value: profile?.phone);
    await storage.write(key: "birthDate", value: profile?.birthDate);
    await storage.write(key: "gender", value: profile?.gender?.label);

    /// TODO: save address to storage
  }

  /// profile's address will be null, not handled yet
  Future<Profile> _loadCurrentProfile() async {
    final username = await storage.read(key: "username");
    final fullName = await storage.read(key: "fullName");
    final email = await storage.read(key: "email");
    final phone = await storage.read(key: "phone");
    final birthDate = await storage.read(key: "birthDate");
    final gender = await storage.read(key: "gender");

    final hasNull = [
      username,
      fullName,
      email,
      phone,
      birthDate,
      birthDate,
      gender
    ].any((obj) => obj == null);
    if (hasNull) return null;

    currentUserProfile = Profile(
      username: username,
      fullName: fullName,
      email: email,
      phone: phone,
      birthDate: birthDate,
      gender: Gender(gender),
    );

    /// TODO: load address from storage

    return currentUserProfile;
  }
}
