import "package:flutter/material.dart";
import "package:firebase_messaging/firebase_messaging.dart";

abstract class AppPlugin {
  void onInitState(BuildContext context);
}

class NotificationPlugin extends AppPlugin {
  @override
  void onInitState(BuildContext context) {
    _getFcmToken(context);
  }

  void _getFcmToken(BuildContext context) async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging();
    final token = await firebaseMessaging.getToken();
    firebaseMessaging.requestNotificationPermissions();
    print("Firebase token:" + token);

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("on message $message");
        _showDialog(context);
      },
      onResume: (Map<String, dynamic> message) async {
        print("on resume $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("on launch $message");
      },
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => Text('Hello'));
  }
}

class AppContainer extends StatefulWidget {
  AppContainer({this.child, this.plugins});

  List<AppPlugin> plugins;
  Widget child;

  @override
  State<StatefulWidget> createState() {
    return AppContainerState();
  }
}

class AppContainerState extends State<AppContainer> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      widget.plugins.forEach((p) => p.onInitState(context));
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
