import 'package:flutter_keychain/flutter_keychain.dart';

// logout
void clearData() {
  setUsername('');
  setToken('');
  setRefreshToken('');
  setExpireIn(0);
}

Future<bool> isLogin() async {
  final username = await getUsername();
  return username != null && username.isNotEmpty;
}

Future<bool> isGoogleLogin() async {
  final googleId = await getGoogleId();
  return googleId != null && googleId.isNotEmpty;
}

// Google Sign In
Future<String> getGoogleId() async {
  return await FlutterKeychain.get(key: "googleId");
}

void setGoogleId(String id) async {
  return await FlutterKeychain.put(key: "googleId", value: id);
}

// Username
Future<String> getUsername() async {
  return await FlutterKeychain.get(key: "username");
}

void setUsername(String username) async {
  return await FlutterKeychain.put(key: "username", value: username);
}

// TOKEN
Future<String> getToken() async {
  return await FlutterKeychain.get(key: "token");
}

void setToken(String token) async {
  return await FlutterKeychain.put(key: "token", value: token);
}

// refresh token
Future<String> getRefreshToken() async {
  return await FlutterKeychain.get(key: "refreshToken");
}

void setRefreshToken(String refreshToken) async {
  return await FlutterKeychain.put(key: "refreshToken", value: refreshToken);
}

// expire in
Future<int> getExpireIn() async {
  return int.parse(await FlutterKeychain.get(key: "expireIn"));
}

void setExpireIn(int expireIn) async {
  return await FlutterKeychain.put(key: "expireIn", value: expireIn.toString());
}
