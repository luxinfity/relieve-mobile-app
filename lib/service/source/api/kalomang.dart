import 'package:http/http.dart' as http;
import 'package:relieve_app/app_config.dart';
import 'package:relieve_app/service/model/weather.dart';
import 'package:relieve_app/service/service.dart';
import 'dart:convert';

import 'package:relieve_app/utils/preference_utils.dart' as pref;

class KalomangApi extends BaseApi {
  @override
  final String serverName = 'kalomang';

  KalomangApi(AppConfig appConfig) : super(appConfig);

  Future<WeatherResponse> weatherCheck(double lat, double lang) async {
    var uri = '$completeUri/weather/$lat,$lang';

    final headers = {
      'authorization': await pref.getToken(),
      'secret': secret,
    };

    final response = await http.get(uri, headers: headers);

    return WeatherResponse.fromJson(jsonDecode(response.body));
  }
}
