import 'package:flushbar/flushbar.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class TopSnackbar {
  static Flushbar create({@required String message}) {
    return Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      message: message,
      duration: Duration(milliseconds: 1000),
      animationDuration: Duration(milliseconds: 400),
      forwardAnimationCurve: Curves.decelerate,
      reverseAnimationCurve: Curves.decelerate,
    );
  }
}
