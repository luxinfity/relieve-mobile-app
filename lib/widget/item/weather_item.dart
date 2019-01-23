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
        return LocalImage.ic_wind.toSvg(width: 48);
      case WeatherType.UV:
        return LocalImage.ic_uv.toSvg(width: 48);
      default:
        return LocalImage.ic_rain.toSvg(width: 48);
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
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(Dimen.x10),
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
            Container(
              child: createImage(),
              padding: const EdgeInsets.only(left: Dimen.x6, top: Dimen.x10),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.all(Dimen.x8),
                child: createValueView(),
              ),
              top: 1,
              right: 1,
            ),
          ],
        ),
      ),
    );
  }
}
