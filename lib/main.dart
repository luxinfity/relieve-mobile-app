import 'package:flutter/material.dart';

import 'screen/boarding/boarding_home.dart';
import 'config/route.dart';
import 'config/application.dart';
import 'res/font.dart';
import 'res/color.dart';

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
                primaryColor: AppColor.colorPrimary,
                primaryColorDark: AppColor.colorPrimaryDark,
                accentColor: AppColor.colorAccent,
                backgroundColor: Colors.white,
                fontFamily: CircularStdFont.defaultName,
            ),
            home: BoadingHome(title: 'Relieve ID Home Page'),
            onGenerateRoute: Application.router.generator,
        );
    }
}