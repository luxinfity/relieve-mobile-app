import 'package:flushbar/flushbar.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class TopSnackbar {
  static Flushbar create({@required String message}) {
    return Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      message: message,
      duration: Duration(milliseconds: 1200),
      animationDuration: Duration(milliseconds: 200),
      forwardAnimationCurve: Curves.decelerate,
      reverseAnimationCurve: Curves.decelerate,
    );
  }

  static Flushbar createAction(
      {@required String message, @required FlatButton button}) {
    return create(message: message)
      ..duration = null
      ..mainButton = button;
  }
}
