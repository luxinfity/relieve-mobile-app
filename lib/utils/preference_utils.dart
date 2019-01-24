import 'package:shared_preferences/shared_preferences.dart';

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
