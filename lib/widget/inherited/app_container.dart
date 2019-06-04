import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

abstract class AppPlugin {
  void onContextUpdate(BuildContext context);
}

class NotificationPlugin extends AppPlugin {
  NotificationPlugin({this.context}) {
    _getFcmToken();
  }

  BuildContext context;

  @override
  void onContextUpdate(BuildContext context) {
    this.context = context;
  }

  void _getFcmToken() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging();
    final token = await firebaseMessaging.getToken();
    firebaseMessaging.requestNotificationPermissions();
    print('Firebase token:' + token);

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
        _showDialog();
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void _showDialog() {
    print('showing dialog');
    showDialog(context: context, builder: (context) => Text('Hello'));
  }
}

enum AppType { Debug, Production }

// ignore: must_be_immutable
class AppContainer extends InheritedWidget {
  List<AppPlugin> plugins;
  AppType appType;
  Widget child;
  BuildContext currentContext;

  AppContainer(this.appType, {this.child, this.plugins});

  static AppContainer _of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AppContainer);
  }

  static void update(BuildContext context) {
    _of(context)
      ..currentContext = context
      .._onContextUpdate();
  }

  void _onContextUpdate() {
    plugins.forEach((plugins) => plugins.onContextUpdate(currentContext));
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
