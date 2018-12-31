import 'package:flutter/material.dart';

typedef VoidContextCallback = void Function(BuildContext context);

void defaultBackPressed(BuildContext context) {
  Navigator.pop(context);
}
