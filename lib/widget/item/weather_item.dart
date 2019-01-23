import 'package:flutter/material.dart';

import '../../res/res.dart';

enum WeatherType { Rain, Wind, UV }

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
      case WeatherType.Wind:
        return LocalImage.ic_wind.toSvg(width: 38);
      case WeatherType.UV:
        return LocalImage.ic_uv.toSvg(width: 40);
      default:
        return LocalImage.ic_rain.toSvg(width: 42);
    }
  }

  String getMetric() {
    switch (weatherType) {
      case WeatherType.Wind:
        return 'kph';
      case WeatherType.UV:
        return 'uv';
      default:
        return 'in';
    }
  }

  Widget createValueView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          value.toString(),
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
        height: 110,
        padding: const EdgeInsets.all(Dimen.x10),
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              child: Text(
                classification,
                style: CircularStdFont.medium.getStyle(
                  size: Dimen.x14,
                  color: AppColor.colorPrimary,
                ),
              ),
              alignment: Alignment.bottomCenter,
            ),
            createImage(),
            Positioned(
              child: createValueView(),
              top: 1,
              right: 1,
            ),
          ],
        ),
      ),
    );
  }
}
