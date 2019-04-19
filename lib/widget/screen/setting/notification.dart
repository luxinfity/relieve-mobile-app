import "package:flutter/material.dart";

import "package:relieve_app/res/res.dart";
import "package:relieve_app/widget/common/standard_button.dart";
import "package:relieve_app/widget/common/relieve_scaffold.dart";

class NotificationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NotificationScreenState();
  }
}

class NotificationScreenState extends State {
  @override
  Widget build(BuildContext context) {
    return RelieveScaffold(
      childs: <Widget>[
        StandardButton(
          key: Key("home-login"),
          text: "Login Now",
          backgroundColor: AppColor.colorPrimary,
          buttonClick: () {},
        )
      ],
    );
  }
}
