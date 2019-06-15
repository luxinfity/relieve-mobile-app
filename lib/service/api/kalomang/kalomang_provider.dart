import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:relieve_app/datamodel/weather.dart';
import 'package:relieve_app/service/api/base/provider.dart';
import 'package:relieve_app/service/api/kalomang/kalomang_api.dart';
import 'package:relieve_app/utils/common_utils.dart';
import 'package:relieve_app/utils/preference_utils.dart';

class KalomangProvider extends Provider implements KalomangApi {
  @override
  final String name = 'kalomang';

  /// return null if cannot connect or response is in wrong format
  @override
  Future<WeatherResponse> weatherCheck(double lat, double lang) async {
    this.checkProvider();

    var uri = '$completeUri/weather/?loc=$lat,$lang';

    final headers = {
      'authorization': await PreferenceUtils.get().getIdToken(),
      'secret': secret,
    };

    try {
      final response = await http.get(uri, headers: headers);
      return WeatherResponse.fromJson(jsonDecode(response.body));
    } catch (error) {
      debugLog(KalomangProvider).info(error);
      return null;
    }
  }
}
