import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:relieve_app/datamodel/address.dart';
import 'package:relieve_app/datamodel/gender.dart';
import 'package:relieve_app/datamodel/profile.dart';
import 'package:relieve_app/utils/common_utils.dart';

abstract class PreferenceKey {
  static const String USERNAME = "username";
  static const String FULL_NAME = "fullName";
  static const String EMAIL = "email";
  static const String PHONE = "phone";
  static const String BIRTH_DATE = "birthDate";
  static const String GENDER = "gender";
  static const String ADDRESSES = "addresses";
  static const String ADDRESS_ACTIVE = "addressActive";
}

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
  Profile currentUserProfile;
  int currentActiveAddress;

  /// Clear all pref on user phone.
  /// don't forget to call this method on logout action
  void clearData() {
    // clear profile instance
    currentUserProfile = null;
    currentActiveAddress = 0;

    storage.deleteAll();
  }

  /// nullable response,
  /// will return null when user is not logged in
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

  void saveActiveAddressIndex(int index) async {
    await storage.write(
        key: PreferenceKey.ADDRESS_ACTIVE, value: index.toString());
  }

  Future<int> _getActiveAddressIndex() async {
    final indexStr = await storage.read(key: PreferenceKey.ADDRESS_ACTIVE);
    return int.tryParse(indexStr) ?? 0;
  }

  void saveCurrentProfile(Profile profile) async {
    currentUserProfile = profile;
    currentActiveAddress = await _getActiveAddressIndex();

    await storage.write(key: PreferenceKey.USERNAME, value: profile?.username);
    await storage.write(key: PreferenceKey.FULL_NAME, value: profile?.fullName);
    await storage.write(key: PreferenceKey.EMAIL, value: profile?.email);
    await storage.write(key: PreferenceKey.PHONE, value: profile?.phone);
    await storage.write(
        key: PreferenceKey.BIRTH_DATE, value: profile?.birthDate);
    await storage.write(
        key: PreferenceKey.GENDER, value: profile?.gender?.label);
    await storage.write(
        key: PreferenceKey.ADDRESSES,
        value: jsonEncode(profile?.addressesToListMap()) ?? []);
  }

  Future<Profile> _loadCurrentProfile() async {
    final username = await storage.read(key: PreferenceKey.USERNAME);
    final fullName = await storage.read(key: PreferenceKey.FULL_NAME);
    final email = await storage.read(key: PreferenceKey.EMAIL);
    final phone = await storage.read(key: PreferenceKey.PHONE);
    final birthDate = await storage.read(key: PreferenceKey.BIRTH_DATE);
    final gender = await storage.read(key: PreferenceKey.GENDER);
    final addresses = await storage.read(key: PreferenceKey.ADDRESSES);

    final jsonDecoded = jsonDecode(addresses) as List<Map<String, dynamic>>;
    final decodedAddress = jsonDecoded.map((data) => Address.fromJson(data));

    final hasNull = [
      username,
      fullName,
      email,
      phone,
      birthDate,
      birthDate,
      gender,
      decodedAddress
    ].any((obj) => obj == null);
    if (hasNull) return null;

    currentActiveAddress = await _getActiveAddressIndex();
    currentUserProfile = Profile(
      username: username,
      fullName: fullName,
      email: email,
      phone: phone,
      birthDate: birthDate,
      gender: Gender(gender),
      addresses: decodedAddress,
    );

    return currentUserProfile;
  }
}
