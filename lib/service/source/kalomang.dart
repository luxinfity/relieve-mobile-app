import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

import './base.dart';
import '../model/token.dart';
import '../../utils/preference_utils.dart' as pref;

class KalomangApi {
  static const String serverName = "kalomang";
  static const String completeName = "$PROTOCOL$serverName.$DOMAIN";
  static const String secret = "BdQv7AHrFsAb5JMwYN6OZvCMSn7lU5nB";

  static Future<TokenResponse> weatherCheck(double lat, double lang) async {
    final token = await pref.getToken();
    var queryParameters = {
      'coordinates': '$lat,$lang',
      'token': token,
    };
    final uri = Uri.https(
      '$serverName.$DOMAIN',
      '/weather/check',
      queryParameters,
    );

    final response = await http.get(uri, headers: {'secret': secret});

    return TokenResponse.fromJson(jsonDecode(response.body));
  }
}
