import 'package:http/http.dart' as http;
import 'package:relieve_app/service/model/disaster.dart';
import 'package:relieve_app/service/model/weather.dart';
import 'package:relieve_app/service/service.dart';
import 'package:relieve_app/service/source/api/provider.dart';
import 'dart:convert';

import 'package:relieve_app/utils/preference_utils.dart' as pref;

class KalomangProvider extends Provider implements KalomangApi {
  @override
  final String name = 'kalomang';

  @override
  Future<WeatherResponse> weatherCheck(double lat, double lang) async {
    this.checkProvider();

    var uri = '$completeUri/weather/$lat,$lang';
    final headers = {
      'authorization': await pref.getToken(),
      'secret': secret,
    };

    final response = await http.get(uri, headers: headers);

    return WeatherResponse.fromJson(jsonDecode(response.body));
  }

  @override
  Future<DisasterResponse> getDisasterList(int page, int limit) async {
    this.checkProvider();

    var uri = '$completeUri/earthquake?page=$page&limit=$limit';
    final headers = {
      'authorization': await pref.getToken(),
      'secret': secret,
    };

    final response = await http.get(uri, headers: headers);

    return DisasterResponse.fromJson(jsonDecode(response.body));
  }
}
