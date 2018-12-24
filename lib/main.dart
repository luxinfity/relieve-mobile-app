import 'package:flutter/material.dart';

import 'view/home.dart';
import 'res/font.dart';
import 'res/color.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Relieve ID',
      theme: ThemeData(
        primaryColor: AppColor.colorPrimary,
        primaryColorDark: AppColor.colorPrimaryDark,
        accentColor: AppColor.colorAccent,
        backgroundColor: Colors.white,
        fontFamily: CircularStdFont.name,
      ),
      home: MyHomePage(title: 'Relieve ID Home Page'),
    );
  }
}