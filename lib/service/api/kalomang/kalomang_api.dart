import 'package:relieve_app/datamodel/disaster.dart';
import 'package:relieve_app/datamodel/weather.dart';

abstract class KalomangApi {
  Future<WeatherResponse> weatherCheck(double lat, double lang);

  Future<DisasterResponse> getDisasterList(int page, int limit,
      {List<DisasterType> filters});
}
