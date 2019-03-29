import "./base.dart";

class WeatherDescription {
  final String id;
  final String en;

  const WeatherDescription({this.id, this.en});

  factory WeatherDescription.fromJson(Map<String, dynamic> parsedJson) {
    try {
      return WeatherDescription(
        en: parsedJson["en"],
        id: parsedJson["id"],
      );
    } catch (e) {
      return null;
    }
  }
}

class Weather {
  final WeatherDescription desc;
  final double value;

  const Weather(
      {this.desc = const WeatherDescription(en: "", id: ""), this.value = 0});

  factory Weather.fromJson(Map<String, dynamic> parsedJson) {
    try {
      return Weather(
        desc: WeatherDescription.fromJson(parsedJson["desc"]),
        value: double.parse(parsedJson["value"].toString()),
      );
    } catch (e) {
      return null;
    }
  }
}

class WeatherItem {
  final Weather temparature;
  final Weather wind;
  final Weather uv;
  final Weather rain;

  const WeatherItem({
    this.temparature = const Weather(),
    this.wind = const Weather(),
    this.uv = const Weather(),
    this.rain = const Weather(),
  });

  factory WeatherItem.fromJson(Map<String, dynamic> parsedJson) {
    try {
      return WeatherItem(
        temparature: Weather.fromJson(parsedJson["temperature"]),
        wind: Weather.fromJson(parsedJson["wind_speed"]),
        uv: Weather.fromJson(parsedJson["uv_index"]),
        rain: Weather.fromJson(parsedJson["rain_intensity"]),
      );
    } catch (e) {
      return null;
    }
  }
}

class WeatherResponse extends BaseResponse {
  @override
  final WeatherItem content;

  WeatherResponse({
    String message,
    int status,
    this.content = const WeatherItem(),
  }) : super(message, status, content);

  factory WeatherResponse.fromJson(Map<String, dynamic> parsedJson) {
    try {
      return WeatherResponse(
        message: parsedJson["message"],
        content: WeatherItem.fromJson(parsedJson["content"]),
        status: parsedJson["status"],
      );
    } catch (e) {
      return null;
    }
  }
}
