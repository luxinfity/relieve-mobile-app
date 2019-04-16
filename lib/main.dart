import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:relieve_app/app_config.dart";
import 'package:relieve_app/app_container.dart';
import "package:relieve_app/landing_screen.dart";
import "package:relieve_app/res/res.dart";

void main() {
  var configuredApp = new AppConfig(
    flavorName: "production",
    apiProtocol: "https",
    apiUrlPrefix: "",
    child: new MyApp(),
  );

  runApp(configuredApp);
}

class MyApp extends StatelessWidget {
  // This widget is the root of my application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return AppContainer(
      plugins: [NotificationPlugin()],
      child: MaterialApp(
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
          home: LandingScreen()),
    );
  }
}
