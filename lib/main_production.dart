import 'package:catcher/catcher_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:relieve_app/datamodel/remote_env.dart';
import 'package:relieve_app/home_decider.dart';
import 'package:relieve_app/widget/inherited/app_container.dart';

import 'res/export.dart';

void main() {
  RemoteEnv.storeEnv(RemoteEnv.PRODUCTION);

  // console logger, turned off
  Logger.root.level = Level.OFF;

  // exception catcher
  CatcherOptions releaseOptions = CatcherOptions(DialogReportMode(), [
    EmailManualHandler(["relieveid.app@gmail.com"])
  ]);

  Catcher(MyApp(), releaseConfig: releaseOptions);
}

class MyApp extends StatelessWidget {
  // This widget is the root of my application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return AppContainer(
      plugins: [NotificationPlugin()],
      child: MaterialApp(
          title: 'Relieve ID',
          navigatorKey: Catcher.navigatorKey,
          theme: ThemeData(
            primaryColor: AppColor.colorPrimary,
            primaryColorDark: AppColor.colorPrimaryDark,
            accentColor: AppColor.colorAccent,
            backgroundColor: Colors.white,
            canvasColor: Colors.transparent,
            fontFamily: CircularStdFont.book.fontFamily,
            hintColor: AppColor.colorEmptyRect,
          ),
          home: HomeDecider()),
    );
  }
}
