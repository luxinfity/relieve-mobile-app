import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:relieve_app/res/res.dart';
import 'package:relieve_app/widget/inherited/app_container.dart';
import 'package:relieve_app/widget/screen/landing_screen.dart';

void main() {
  Stetho.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of my application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return AppContainer(
      AppType.Debug,
      plugins: [NotificationPlugin()],
      child: MaterialApp(
          title: 'Relieve ID',
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
