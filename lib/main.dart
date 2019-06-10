import 'package:catcher/catcher_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:logging/logging.dart';
import 'package:relieve_app/datamodel/remote_env.dart';
import 'package:relieve_app/home_decider.dart';
import 'package:relieve_app/res/res.dart';
import 'package:relieve_app/widget/inherited/app_container.dart';

void main() {
  // http logger
  Stetho.initialize();

  // console logger
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  // exception catcher
  CatcherOptions debugOptions =
      CatcherOptions(DialogReportMode(), [ConsoleHandler()]);

  // TODO: delete later
  // Temporary: Mock Server
  final mockServer = RemoteEnv('Postman Mock', 'https',
      'c119ba48-3e35-48bd-8334-75cfe80c20d8.mock.pstmn.io', '', '');
  RemoteEnv.storeEnv(mockServer);

  Catcher(MyApp(), debugConfig: debugOptions);
}

class MyApp extends StatelessWidget {
  // This widget is the root of my application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return AppContainer(
      plugins: [NotificationPlugin()],
      child: MaterialApp(
          title: 'Relieve ID Debug',
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
