import 'package:http/http.dart' as http;
import 'dart:convert';

import './base.dart';
import '../model/weather.dart';
import '../../utils/preference_utils.dart' as pref;

class KalomangApi {
  static const String serverName = "kalomang";
  static const String completeName = "$PROTOCOL$serverName.$DOMAIN";
  static const String secret = "BdQv7AHrFsAb5JMwYN6OZvCMSn7lU5nB";

  static Future<WeatherResponse> weatherCheck(double lat, double lang) async {
    var queryParameters = {'coordinates': '$lat,$lang'};
    final uri = Uri.https(
      '$serverName.$DOMAIN',
      '/weather/check',
      queryParameters,
    );

    final headers = {
      'authorization': await pref.getToken(),
      'secret': secret,
    };

    final response = await http.get(uri, headers: headers);

    return WeatherResponse.fromJson(jsonDecode(response.body));
  }
}
