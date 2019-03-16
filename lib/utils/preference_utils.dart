import 'package:shared_preferences/shared_preferences.dart';

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
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('googleId');
}

Future<bool> setGoogleId(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setString('googleId', id);
}

// Username
Future<String> getUsername() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('username');
}

Future<bool> setUsername(String username) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setString('username', username);
}

// TOKEN
Future<String> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

Future<bool> setToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setString('token', token);
}

// refresh token
Future<String> getRefreshToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('refreshToken');
}

Future<bool> setRefreshToken(String refreshToken) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setString('refreshToken', refreshToken);
}

// expire in
Future<int> getExpireIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('expireIn');
}

Future<bool> setExpireIn(int expireIn) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setInt('expireIn', expireIn);
}
