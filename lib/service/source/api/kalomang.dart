import 'package:http/http.dart' as http;
import 'dart:convert';

import '../api/config.dart';
import '../../../app_config.dart';
import '../../model/weather.dart';
import '../../../utils/preference_utils.dart' as pref;

class KalomangApi extends BaseApi {
  @override
  final String serverName = "kalomang";

  KalomangApi(AppConfig appConfig) : super(appConfig);

  Uri createUri(double lat, double lang) {
    var queryParameters = {'coordinates': '$lat,$lang'};
    if (appConfig.apiProtocol == "https") {
      return Uri.https(
        completeName,
        '/weather/check',
        queryParameters,
      );
    } else {
      return Uri.http(
        completeName,
        '/weather/check',
        queryParameters,
      );
    }
  }

  Future<WeatherResponse> weatherCheck(double lat, double lang) async {
    final uri = createUri(lat, lang);

    final headers = {
      'authorization': await pref.getToken(),
      'secret': secret,
    };

    print(headers);

    final response = await http.get(uri, headers: headers);

    return WeatherResponse.fromJson(jsonDecode(response.body));
  }
}
