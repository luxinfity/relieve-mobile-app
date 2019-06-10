import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:relieve_app/res/res.dart';

abstract class RelieveLoadingDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: SpinKitPumpingHeart(
            itemBuilder: (context, index) {
              return RemoteImage.icAppCircle.toImage(
                height: 100,
                fadeInDuration: Duration(milliseconds: 0),
              );
            },
          ),
        );
      },
    );
  }

  static void dismiss(BuildContext context) {
    Navigator.pop(context);
  }
}
