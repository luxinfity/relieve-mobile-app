import "package:flutter/material.dart";
import "package:firebase_messaging/firebase_messaging.dart";
import "package:relieve_app/screen/boarding/boarding_home.dart";
import "package:relieve_app/screen/dashboard/dashboard.dart";
import 'package:relieve_app/utils/common_utils.dart';
import "utils/preference_utils.dart" as pref;

class LandingScreen extends StatelessWidget {
  void getFcmToken() async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    final token = await _firebaseMessaging.getToken();
    _firebaseMessaging.requestNotificationPermissions();
    print(token);
    // TODO: save fcm token

//    _firebaseMessaging.configure(
//      onMessage: (Map<String, dynamic> message) async {
//        print("on message $message");
//      },
//      onResume: (Map<String, dynamic> message) async {
//        print("on resume $message");
//      },
//      onLaunch: (Map<String, dynamic> message) async {
//        print("on launch $message");
//      },
//    );
  }

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
    getFcmToken();
    checkLogin(context);

    return Container(
      alignment: Alignment.center,
      color: Colors.white,
    );
  }
}
