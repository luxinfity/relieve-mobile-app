import 'package:flutter/material.dart';

class CircularStdFont {
  final String fontFamily;

  const CircularStdFont({this.fontFamily = 'CircularStdBook'});

  TextStyle getStyle({double size = 12.0, Color color = Colors.black}) {
    return TextStyle(fontFamily: fontFamily, fontSize: size, color: color);
  }

  static CircularStdFont get book => CircularStdFont();

  static CircularStdFont get medium =>
      CircularStdFont(fontFamily: 'CircularStdMedium');

  static CircularStdFont get bold =>
      CircularStdFont(fontFamily: 'CircularStdBold');

  static CircularStdFont get black =>
      CircularStdFont(fontFamily: 'CircularStdBlack');
}
