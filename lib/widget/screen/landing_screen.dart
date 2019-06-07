import 'package:flutter/material.dart';
import 'package:relieve_app/utils/preference_utils.dart';
import 'package:relieve_app/widget/screen/boarding/boarding_home.dart';
import 'package:relieve_app/widget/screen/dashboard/dashboard.dart';

class LandingScreen extends StatelessWidget {
  void checkLogin(BuildContext context) async {
    final isLogin = await PreferenceUtils.isLogin();
    if (isLogin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (builder) => DashboardScreen(),
        ),
      );
    } else {
      // not login but has google ID
      if (await PreferenceUtils.isGoogleLogin()) {
//        googleSignInScope.signOut();
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
