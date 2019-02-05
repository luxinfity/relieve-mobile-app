import 'package:flutter/material.dart';

import 'screen/boarding/boarding_home.dart';
import 'screen/dashboard/dashboard.dart';
import 'utils/preference_utils.dart' as pref;

class LandingScreen extends StatelessWidget {
  void checkLogin(BuildContext context) async {
    final isLogin = await pref.isLogin();
    if (isLogin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (builder) => DashboardScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (builder) => BoardingHomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    checkLogin(context);

    return Container(
      alignment: Alignment.center,
      color: Colors.white,
    );
  }
}
