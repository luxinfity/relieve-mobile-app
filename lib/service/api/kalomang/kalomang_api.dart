import 'package:relieve_app/datamodel/weather.dart';

abstract class KalomangApi {
  Future<WeatherResponse> weatherCheck(double lat, double lang);
}
