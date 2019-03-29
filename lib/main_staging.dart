import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_stetho/flutter_stetho.dart";

import "landing_screen.dart";
import "./app_config.dart";
import "res/res.dart";

void main() {
  var configuredApp = new AppConfig(
    flavorName: "staging",
    apiProtocol: "http",
    apiUrlPrefix: "staging-",
    child: new MyApp(),
  );
  Stetho.initialize();

  runApp(configuredApp);
}

class MyApp extends StatelessWidget {
  // This widget is the root of my application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MaterialApp(
        title: "Relieve ID",
        theme: ThemeData(
          primaryColor: AppColor.colorPrimary,
          primaryColorDark: AppColor.colorPrimaryDark,
          accentColor: AppColor.colorAccent,
          backgroundColor: Colors.white,
          canvasColor: Colors.transparent,
          fontFamily: CircularStdFont.book.fontFamily,
          hintColor: AppColor.colorEmptyRect,
        ),
        home: LandingScreen());
  }
}
