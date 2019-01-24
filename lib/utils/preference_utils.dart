import 'package:shared_preferences/shared_preferences.dart';

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

Future<bool> setExpireIn(String refreshToken) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setString('expireIn', refreshToken);
}