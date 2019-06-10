import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:relieve_app/datamodel/disaster.dart';
import 'package:relieve_app/datamodel/weather.dart';
import 'package:relieve_app/service/api/kalomang/kalomang_api.dart';
import 'package:relieve_app/service/api/provider.dart';

class KalomangProvider extends Provider implements KalomangApi {
  @override
  final String name = 'kalomang';

  @override
  Future<WeatherResponse> weatherCheck(double lat, double lang) async {
    this.checkProvider();

    var uri = '$completeUri/weather/?loc=$lat,$lang';
    final headers = {
//      'authorization': await PreferenceUtils.getToken(),
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
//      'authorization': await PreferenceUtils.getToken(),
      'secret': secret,
    };

    final response = await http.get(uri, headers: headers);

    return DisasterResponse.fromJson(jsonDecode(response.body));
  }
}
