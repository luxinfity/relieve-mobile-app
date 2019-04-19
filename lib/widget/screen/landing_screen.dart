import 'package:flutter/material.dart';
import 'package:relieve_app/widget/screen/boarding/boarding_home.dart';
import 'package:relieve_app/widget/screen/dashboard/dashboard.dart';
import 'package:relieve_app/utils/common_utils.dart';
import 'package:relieve_app/utils/preference_utils.dart' as pref;

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
      // not login but has google ID
      if (await pref.isGoogleLogin()) {
        googleSignInScope.signOut();
      }
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
