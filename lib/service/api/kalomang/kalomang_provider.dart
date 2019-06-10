import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:relieve_app/datamodel/disaster.dart';
import 'package:relieve_app/datamodel/weather.dart';
import 'package:relieve_app/service/api/kalomang/kalomang_api.dart';
import 'package:relieve_app/service/api/provider.dart';
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

  /// return null if cannot connect or response is in wrong format
  @override
  Future<DisasterResponse> getDisasterList(int page, int limit,
      {List<DisasterType> filters = const []}) async {
    this.checkProvider();

    String filterQuery = '';
    if (filters.isNotEmpty)
      filterQuery =
          '&filter=${filters.map((f) => f.name.toLowerCase()).join(',')}';

    final uri = '$completeUri/disaster?page=$page&limit=$limit$filterQuery';
    final headers = {
      'authorization': await PreferenceUtils.get().getIdToken(),
      'secret': secret,
    };

    try {
      final response = await http.get(uri, headers: headers);
      return DisasterResponse.fromJson(jsonDecode(response.body));
    } catch (error) {
      debugLog(KalomangProvider).info(error);
      return null;
    }
  }
}
