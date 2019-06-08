import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:relieve_app/utils/common_utils.dart';

abstract class PreferenceUtils {
  static const _USERNAME_KEY = "username";

  static const _KEYS = [_USERNAME_KEY];

  /// Clear all pref on user phone.
  /// don't forget to call this method on logout action
  static void clearData() {
    _KEYS.forEach((key) {
      FlutterKeychain.put(key: key, value: null);
    });
  }

  static Future<String> uid() async {
    if (await isLogin()) {
      final user = await FirebaseAuth.instance.currentUser();
      return user.uid;
    } else {
      return null;
    }
  }

  static Future<bool> isLogin() async {
    final username = await getUsername();
    return username.isNotEmpty;
  }

  static Future<bool> isGoogleLogin() async {
    final user = await FirebaseAuth.instance.currentUser();
    if (user == null) return false;

    for (UserInfo info in user.providerData) {
      debugLog(PreferenceUtils).info(info.providerId);
      if (info.providerId == "google.com") return true;
    }

    return false;
  }

  // Username
  static Future<String> getUsername() async {
    String data = (await FlutterKeychain.get(key: _USERNAME_KEY)) ?? '';
    return data;
  }

  static void setUsername(String username) async {
    return await FlutterKeychain.put(key: _USERNAME_KEY, value: username);
  }
}
