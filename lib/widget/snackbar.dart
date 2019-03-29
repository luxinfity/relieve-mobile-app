import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:relieve_app/res/res.dart';

Flushbar flush;

void showSnackBar(
  BuildContext context,
  String text, {
  String buttonText,
  Color buttonTextColor,
  Color backgroundColor,
  VoidCallback onClick,
}) {
  Flushbar(
    flushbarStyle: FlushbarStyle.FLOATING,
    aroundPadding:
        EdgeInsets.symmetric(horizontal: Dimen.x16, vertical: Dimen.x16),
    backgroundColor:
        (backgroundColor == null) ? AppColor.colorTextBlack : backgroundColor,
    message: text,
    mainButton: (buttonText != null)
        ? FlatButton(
            child: Text(
              buttonText,
              style: CircularStdFont.medium.getStyle(
                  size: Dimen.x14,
                  color: (buttonTextColor == null)
                      ? AppColor.colorAccent
                      : buttonTextColor),
            ),
            onPressed: () {
              if (onClick != null) onClick();
              flush?.dismiss(true);
            },
          )
        : null,
    duration: Duration(seconds: 4),
    borderRadius: Dimen.x8,
  )..show(context);
}
