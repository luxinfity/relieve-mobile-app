import 'package:flutter/material.dart';

import '../../../res/res.dart';

class RegisterHere extends StatelessWidget {
  final VoidCallback onClick;

  const RegisterHere({Key key, @required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Don’t have an account ?',
            style: CircularStdFont.book
                .getStyle(size: Dimen.x14, color: AppColor.colorTextGrey)),
        FlatButton(
          child: Text('Register Here',
              style: CircularStdFont.book
                  .getStyle(size: Dimen.x14, color: AppColor.colorPrimary)),
          onPressed: onClick,
        )
      ],
    );
  }
}
