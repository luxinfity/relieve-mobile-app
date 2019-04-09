import "package:flutter/material.dart";
import 'package:meta/meta.dart';
import 'package:scoped_model/scoped_model.dart';
import "package:firebase_messaging/firebase_messaging.dart";

class NotificationModel extends Model {
  Map<String, dynamic> _receivedMessage;
  Map<String, dynamic> get receivedMessage => _receivedMessage;

  NotificationModel() {
    getFcmToken();
  }

  void getFcmToken() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging();
    final token = await firebaseMessaging.getToken();
    firebaseMessaging.requestNotificationPermissions();
    print("Firebase token:" + token);

    // TODO: save fcm token

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("on message $message");
        _receivedMessage = message;
        notifyListeners();
      },
      onResume: (Map<String, dynamic> message) async {
        print("on resume $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("on launch $message");
      },
    );
  }
}

class AppContainer extends StatelessWidget {
  AppContainer({@required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: NotificationModel(),
      child: child,
    );
  }
}
