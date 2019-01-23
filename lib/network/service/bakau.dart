import 'package:http/http.dart' as http;
import 'dart:io';

import './base.dart';

class BakauApi {
  static const String serverName = "bakau";
  static const String completeName = "$PROTOCOL$serverName$DOMAIN";
  static const String secret = "BdQv7AHrFsAb5JMwYN6OZvCMSn7lU5nB";

  Future<http.Response> login(String username, String password) {
    var url = "$completeName/login";
    return http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'secret': secret
      },
      body: {
        'username': username,
        'password': password,
      },
    );
  }
}