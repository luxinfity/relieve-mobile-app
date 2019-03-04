import 'package:flutter/material.dart';

/// Use to wrap color, so not need to add `A` value
class HexColor extends Color {
  static int _getColorFromHex(
    String hexColor,
    double transparancy,
  ) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    transparancy = transparancy <= 1 ? transparancy : 1;
    transparancy = transparancy >= 0 ? transparancy : 0;
    final hexTransparancy = (transparancy  * 255).toInt().toRadixString(16);

    if (hexColor.length == 6) {
      hexColor = hexTransparancy + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  final String hexColor;
  HexColor(
    this.hexColor, {
    double transparancy = 1.0, // 100% or FF
  }) : super(_getColorFromHex(hexColor, transparancy));
}

class AppColor {
  static final colorDanger = HexColor('F34949');
  static final colorPrimary = HexColor('1B76BC');
  static final colorPrimaryDark = HexColor('105a93');
  static final colorAccent = HexColor('5EB6F9');
  static final colorTextBlack = HexColor('3D3D3D');
  static final colorTextCharcoal = HexColor('1A1A1A');
  static final colorTextGrey = HexColor('929292');
  static final colorEmptyRect = HexColor('C4C4C4');
  static final colorEmptyChip = HexColor('E5E5E5');
  static final colorStandardBackgroud = HexColor('f9f9f9');
}
