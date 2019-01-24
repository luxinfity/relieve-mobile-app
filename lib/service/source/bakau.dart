import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

import './base.dart';
import '../model/token.dart';
import '../model/user.dart';

class BakauApi {
  static const String serverName = "bakau";
  static const String completeName = "$PROTOCOL$serverName.$DOMAIN";
  static const String secret = "BdQv7AHrFsAb5JMwYN6OZvCMSn7lU5nB";

  static Future<TokenResponse> login(String username, String password) async{    
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

  static Future<TokenResponse> register(User user) async{    
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