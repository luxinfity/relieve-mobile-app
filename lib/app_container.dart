import "package:flutter/material.dart";
import 'package:meta/meta.dart';
import 'package:scoped_model/scoped_model.dart';
import "package:firebase_messaging/firebase_messaging.dart";

typedef NotificationListener = void Function(Map<String, dynamic> map);
typedef BuildContext ContextProvider();

class NotificationController extends InheritedWidget {
  Map<String, dynamic> _receivedMessage;
  List<NotificationListener> listeners = List();

  NotificationController({
    @required Widget child,
  }) : super(child: child) {
    getFcmToken();
  }

  void listen(NotificationListener listener) {
    listeners.add(listener);
  }

  void _broadcast() {
    listeners.forEach((listener) => listener(_receivedMessage));
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
        _broadcast();
      },
      onResume: (Map<String, dynamic> message) async {
        print("on resume $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("on launch $message");
      },
    );
  }

  static startListen(ContextProvider provider, NotificationListener listener) {
    return Future.delayed(Duration.zero, () {
      NotificationController.of(provider()).listen(listener);
    });
  }

  static NotificationController of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(NotificationController);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

class NotificationModel extends Model {
  Map<String, dynamic> _receivedMessage;

  NotificationModel() {
    getFcmToken();
  }

  void consume(Function(Map<String, dynamic> value) consumer) {
    if (_receivedMessage != null) {
      consumer(_receivedMessage);
      _receivedMessage = null;
    }
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
