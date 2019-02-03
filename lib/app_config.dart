import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class AppConfig extends InheritedWidget {
  AppConfig({
    @required this.flavorName,
    @required this.apiProtocol,
    @required this.apiUrlPrefix,
    @required Widget child,
  }) : super(child: child);

  final String flavorName;
  final String apiProtocol;
  final String apiUrlPrefix;

  static AppConfig of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AppConfig);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
