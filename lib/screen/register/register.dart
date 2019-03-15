import 'package:flutter/material.dart';
import 'package:relieve_app/screen/register/register_form.dart';
import 'package:relieve_app/screen/register/register_map.dart';
import 'package:relieve_app/widget/relieve_scaffold.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen> {
  int progressCount = 1;
  int progressTotal = 3;

  Widget createPage() {
    switch (progressCount) {
      case 0:
        return RegisterFormAccount();
      case 1:
        return RegisterFormProfile();
      default:
        return RegisterFormAddress();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RelieveScaffold(
      hasBackButton: true,
      progressCount: progressCount,
      progressTotal: progressTotal,
      crossAxisAlignment: CrossAxisAlignment.start,
      childs: <Widget>[
        Expanded(child: createPage()),
      ],
    );
  }
}
