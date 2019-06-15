import 'package:flutter/material.dart';
import 'package:relieve_app/res/export.dart';
import 'package:relieve_app/widget/common/relieve_scaffold.dart';
import 'package:relieve_app/widget/common/standard_button.dart';

class FamilySettingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FamilySettingScreenState();
  }
}

class FamilySettingScreenState extends State {
  @override
  Widget build(BuildContext context) {
    return RelieveScaffold(
      childs: <Widget>[
        StandardButton(
          key: Key('home-login'),
          text: 'Login Now',
          backgroundColor: AppColor.colorPrimary,
          buttonClick: () {},
        )
      ],
    );
  }
}
