import 'package:flutter/material.dart';

import 'view/home.dart';
import 'res/font.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Relieve ID',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: CircularStdFont.name,
      ),
      home: MyHomePage(title: 'Relieve ID Home Page'),
    );
  }
}