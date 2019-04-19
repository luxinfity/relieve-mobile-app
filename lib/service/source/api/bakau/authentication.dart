import 'dart:_http';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:relieve_app/service/model/token.dart';
import 'package:relieve_app/service/model/user.dart';
import 'package:relieve_app/service/model/user_check.dart';
import 'package:relieve_app/service/service.dart';

mixin Authentication on BaseApi {
  // Auth
  Future<UserCheckResponse> checkUser(
      UserCheckIdentifier checkIdentifier, String value) async {
    var url = '$completeUri/auth/check';
    final response = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'secret': secret
      },
      body: jsonEncode({
        'param': checkIdentifier.toString().split('.')[1],
        'value': value,
      }),
    );

    return UserCheckResponse.fromJson(jsonDecode(response.body));
  }

  Future<TokenResponse> login(String username, String password) async {
    var url = '$completeUri/auth/login';
    final response = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'secret': secret
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    return TokenResponse.fromJson(jsonDecode(response.body));
  }

  Future<TokenResponse> register(User user) async {
    var url = '$completeUri/auth/register';
    final response = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'secret': secret
      },
      body: user.toJson(),
    );

    return TokenResponse.fromJson(jsonDecode(response.body));
  }
}
