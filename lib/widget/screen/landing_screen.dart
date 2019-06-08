import 'package:flutter/material.dart';
import 'package:relieve_app/service/firebase/firebase_auth_helper.dart';
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
      // not login but has google ID,
      // may be user has trying to register before, but not complete
      // so sign out user
      if (await PreferenceUtils.isGoogleLogin()) {
        FirebaseAuthHelper.instance.logout();
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
