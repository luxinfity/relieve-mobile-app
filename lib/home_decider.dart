import 'package:flutter/material.dart';
import 'package:relieve_app/service/firebase/firebase_auth_helper.dart';
import 'package:relieve_app/utils/preference_utils.dart';
import 'package:relieve_app/widget/screen/boarding/boarding_home.dart';
import 'package:relieve_app/widget/screen/dashboard/dashboard_screen.dart';

/// Decision page, select main page base on login condition
class HomeDecider extends StatelessWidget {
  void goToLoggedInHomeScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (builder) => DashboardScreen(),
      ),
    );
  }

  void goToLoggedOutHomeScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (builder) => BoardingHomeScreen(),
      ),
    );
  }

  void pickHomeScreenBasedOn(BuildContext context) async {
    if (await PreferenceUtils.isLogin()) {
      goToLoggedInHomeScreen(context);
    } else {
      // not login but has google ID,
      // may be user has trying to register before, but not complete
      // so sign out user
      FirebaseAuthHelper.instance.logout();
      goToLoggedOutHomeScreen(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    pickHomeScreenBasedOn(context);

    return Container(
      alignment: Alignment.center,
      color: Colors.white,
    );
  }
}
