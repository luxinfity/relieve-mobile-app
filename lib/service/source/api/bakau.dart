import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

import '../api/config.dart';
import '../../../app_config.dart';
import '../../model/token.dart';
import '../../model/user.dart';

class BakauApi extends BaseApi {
  @override
  final String serverName = "bakau";

  BakauApi(AppConfig appConfig) : super(appConfig);

  Future<TokenResponse> login(String username, String password) async {
    var url = "$completeName/auth/login";
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
    var url = "$completeName/auth/register";
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
