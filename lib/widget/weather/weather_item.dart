import 'package:flutter/material.dart';
import 'package:relieve_app/widget/inherited/app_config.dart';
import 'package:relieve_app/res/res.dart';
import 'package:relieve_app/service/model/weather.dart';
import 'package:relieve_app/service/service.dart';

enum WeatherType { Temparature, Rain, Wind, UV }

class WeatherItem extends StatelessWidget {
  final WeatherType weatherType;
  final double value;
  final String classification;

  const WeatherItem({
    Key key,
    this.weatherType,
    this.value,
    this.classification,
  }) : super(key: key);

  Widget createImage() {
    switch (weatherType) {
      case WeatherType.Temparature:
        return LocalImage.ic_temperature.toSvg(width: 24);
      case WeatherType.Wind:
        return LocalImage.ic_wind.toSvg(width: 24);
      case WeatherType.UV:
        return LocalImage.ic_sun.toSvg(width: 24);
      default:
        return LocalImage.ic_rain.toSvg(width: 24);
    }
  }

  String getMetric() {
    switch (weatherType) {
      case WeatherType.Temparature:
        return 'c';
      case WeatherType.Wind:
        return 'kph';
      case WeatherType.UV:
        return 'uv';
      default:
        return '%';
    }
  }

  Widget createValueView() {
    var strVal = '';

    switch (weatherType) {
      case WeatherType.Temparature:
        strVal += '${value.toInt()}°';
        break;
      case WeatherType.Rain:
        strVal += '${(value * 100).toInt()}';
        break;
      default:
        strVal += value.toInt().toString();
        break;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          strVal,
          style: CircularStdFont.bold.getStyle(
            size: Dimen.x21,
            color: AppColor.colorTextBlack,
          ),
        ),
        Text(
          getMetric(),
          style: CircularStdFont.bold.getStyle(
            size: Dimen.x14,
            color: AppColor.colorTextBlack,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(Dimen.x10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            createImage(),
            Container(height: Dimen.x4),
            createValueView(),
            Expanded(
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Text(
                  classification,
                  softWrap: true,
                  style: CircularStdFont.medium.getStyle(
                    size: Dimen.x14,
                    color: AppColor.colorPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherItemList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WeatherItemListState();
  }
}

class WeatherItemListState extends State {
  WeatherResponse _weatherResponse = WeatherResponse();

  void fetchData() async {
    if (!await LocationService.isLocationRequestPermitted()) {
      LocationService.showAskPermissionModal(context, () {
        fetchData();
      });
      return;
    }

    final userLocation = await LocationService.getLastKnownLocation();
    if (userLocation != null) {
      final response = await KalomangApi(AppConfig.of(context)).weatherCheck(
        userLocation.latitude,
        userLocation.longitude,
      );
      setState(() {
        _weatherResponse = response;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: Dimen.x16, right: Dimen.x16, bottom: Dimen.x16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: WeatherItem(
              weatherType: WeatherType.Temparature,
              classification:
                  _weatherResponse.content.temparature.desc?.id ?? 'Normal',
              value: _weatherResponse.content.temparature.value,
            ),
          ),
          Container(width: Dimen.x4),
          Expanded(
            child: WeatherItem(
              weatherType: WeatherType.Rain,
              classification: _weatherResponse.content.rain.desc.id,
              value: _weatherResponse.content.rain.value,
            ),
          ),
          Container(width: Dimen.x4),
          Expanded(
            child: WeatherItem(
              weatherType: WeatherType.Wind,
              classification: _weatherResponse.content.wind.desc.id,
              value: _weatherResponse.content.wind.value,
            ),
          ),
          Container(width: Dimen.x4),
          Expanded(
            child: WeatherItem(
              weatherType: WeatherType.UV,
              classification: _weatherResponse.content.uv.desc.id,
              value: _weatherResponse.content.uv.value,
            ),
          ),
        ],
      ),
    );
  }
}
