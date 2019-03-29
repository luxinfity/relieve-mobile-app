import "package:flutter/material.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";
import "package:relieve_app/res/res.dart";

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: SpinKitPumpingHeart(
          itemBuilder: (context, index) {
            return RemoteImage.ic_app_circle.toImage(
              height: 100,
              fadeInDuration: Duration(milliseconds: 0),
            );
          },
        ),
      );
    },
  );
}

void dismissLoadingDialog(BuildContext context) {
  Navigator.pop(context);
  print("dismissd");
}

class DialogTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Text("asa"),
    );
  }
}
