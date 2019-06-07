import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_keychain/flutter_keychain.dart';

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
    final user = await FirebaseAuth.instance.currentUser();
    return user != null;
  }

  static Future<bool> isGoogleLogin() async {
    return false;
    //  final googleId = await getGoogleId();
    //  return googleId != null && googleId.isNotEmpty;
  }

  // Google Sign In
  static Future<String> getGoogleId() async {
    String data = await FlutterKeychain.get(key: 'googleId');
    if (data == null) data = '';
    return data;
  }

  static void setGoogleId(String id) async {
    return await FlutterKeychain.put(key: 'googleId', value: id);
  }

  // Username
  static Future<String> getUsername() async {
    String data = await FlutterKeychain.get(key: 'username');
    if (data == null) data = '';
    return data;
  }

  static void setUsername(String username) async {
    return await FlutterKeychain.put(key: 'username', value: username);
  }

  // TOKEN
  static Future<String> getToken() async {
    String data = await FlutterKeychain.get(key: 'token');
    if (data == null) data = '';
    return data;
  }

  static void setToken(String token) async {
    return await FlutterKeychain.put(key: 'token', value: token);
  }

  // refresh token
  static Future<String> getRefreshToken() async {
    String data = await FlutterKeychain.get(key: 'refreshToken');
    if (data == null) data = '';
    return data;
  }

  static void setRefreshToken(String refreshToken) async {
    return await FlutterKeychain.put(key: 'refreshToken', value: refreshToken);
  }

  // expire in
  static Future<int> getExpireIn() async {
    String data = await FlutterKeychain.get(key: 'expireIn');
    if (data == null) data = '0';
    return int.parse(data);
  }

  static void setExpireIn(int expireIn) async {
    return await FlutterKeychain.put(
        key: 'expireIn', value: expireIn.toString());
  }
}
