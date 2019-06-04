import 'package:relieve_app/service/model/disaster.dart';
import 'package:relieve_app/service/model/weather.dart';

abstract class KalomangApi {
  Future<WeatherResponse> weatherCheck(double lat, double lang);

  Future<DisasterResponse> getDisasterList(int page, int limit);
}
