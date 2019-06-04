import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:relieve_app/datamodel/env.dart';
import 'package:relieve_app/widget/inherited/app_container.dart';
import 'package:relieve_app/widget/screen/landing_screen.dart';

import 'res/res.dart';

void main() {
  Env.storeEnv(Env.PRODUCTION);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of my application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return AppContainer(
      AppType.Production,
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
