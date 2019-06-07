import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_keychain/flutter_keychain.dart';

// logout
void clearData() {
  setGoogleId('');
  setUsername('');
  setToken('');
  setRefreshToken('');
  setExpireIn(0);
}

Future<String> uid() async {
  if (await isLogin()) {
    final user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  } else {
    return null;
  }
}

Future<bool> isLogin() async {
  final user = await FirebaseAuth.instance.currentUser();
  return user != null;
}

Future<bool> isGoogleLogin() async {
  return false;
//  final googleId = await getGoogleId();
//  return googleId != null && googleId.isNotEmpty;
}

// Google Sign In
Future<String> getGoogleId() async {
  String data = await FlutterKeychain.get(key: 'googleId');
  if (data == null) data = '';
  return data;
}

void setGoogleId(String id) async {
  return await FlutterKeychain.put(key: 'googleId', value: id);
}

// Username
Future<String> getUsername() async {
  String data = await FlutterKeychain.get(key: 'username');
  if (data == null) data = '';
  return data;
}

void setUsername(String username) async {
  return await FlutterKeychain.put(key: 'username', value: username);
}

// TOKEN
Future<String> getToken() async {
  String data = await FlutterKeychain.get(key: 'token');
  if (data == null) data = '';
  return data;
}

void setToken(String token) async {
  return await FlutterKeychain.put(key: 'token', value: token);
}

// refresh token
Future<String> getRefreshToken() async {
  String data = await FlutterKeychain.get(key: 'refreshToken');
  if (data == null) data = '';
  return data;
}

void setRefreshToken(String refreshToken) async {
  return await FlutterKeychain.put(key: 'refreshToken', value: refreshToken);
}

// expire in
Future<int> getExpireIn() async {
  String data = await FlutterKeychain.get(key: 'expireIn');
  if (data == null) data = '0';
  return int.parse(data);
}

void setExpireIn(int expireIn) async {
  return await FlutterKeychain.put(key: 'expireIn', value: expireIn.toString());
}
