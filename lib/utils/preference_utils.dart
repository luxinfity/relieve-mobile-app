import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:relieve_app/utils/common_utils.dart';

abstract class PreferenceUtils {
  // logout
  static void clearData() {
    setGoogleId('');
    setUsername('');
    setToken('');
    setRefreshToken('');
    setExpireIn(0);
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

  // Google Sign In
  static Future<String> getGoogleId() async {
    String data = (await FlutterKeychain.get(key: 'googleId')) ?? '';
    return data;
  }

  static void setGoogleId(String id) async {
    return await FlutterKeychain.put(key: 'googleId', value: id);
  }

  // Username
  static Future<String> getUsername() async {
    String data = (await FlutterKeychain.get(key: 'username')) ?? '';
    return data;
  }

  static void setUsername(String username) async {
    return await FlutterKeychain.put(key: 'username', value: username);
  }

  // token
  static Future<String> getToken() async {
    String data = (await FlutterKeychain.get(key: 'token')) ?? '';
    return data;
  }

  static void setToken(String token) async {
    return await FlutterKeychain.put(key: 'token', value: token);
  }

  // refresh token
  static Future<String> getRefreshToken() async {
    String data = (await FlutterKeychain.get(key: 'refreshToken')) ?? '';
    return data;
  }

  static void setRefreshToken(String refreshToken) async {
    return await FlutterKeychain.put(key: 'refreshToken', value: refreshToken);
  }

  // expire in
  static Future<int> getExpireIn() async {
    String data = (await FlutterKeychain.get(key: 'expireIn')) ?? '0';
    return int.parse(data);
  }

  static void setExpireIn(int expireIn) async {
    return await FlutterKeychain.put(
        key: 'expireIn', value: expireIn.toString());
  }
}
