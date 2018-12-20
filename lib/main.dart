import 'package:flutter/material.dart';

import 'screen/boarding/boarding_home.dart';
import 'config/route.dart';
import 'config/application.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp() {
    final router = new MyRouter();
    Application.router = router;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Relieve ID',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Relieve ID Home Page'),
      onGenerateRoute: Application.router.generator,
    );
  }
}