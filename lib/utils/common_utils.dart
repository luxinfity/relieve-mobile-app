import 'package:flutter/material.dart';

typedef VoidContextCallback = void Function(BuildContext context);
typedef StringCallback = String Function();

void defaultBackPressed(BuildContext context) {
  Navigator.pop(context);
}
