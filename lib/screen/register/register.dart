import 'package:flutter/material.dart';
import 'package:relieve_app/screen/register/register_form_account.dart';
import 'package:relieve_app/screen/register/register_form_profile.dart';
import 'package:relieve_app/screen/register/register_map.dart';
import 'package:relieve_app/utils/common_utils.dart';
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
      case 1:
        return RegisterFormAccount(
          onNextClick: () {
            setState(() {
              progressCount += 1;
            });
          },
        );
      case 2:
        return RegisterFormProfile(
          onNextClick: () {
            setState(() {
              progressCount += 1;
            });
          },
        );
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
      onBackPressed: (context) {
        setState(() {
          if (progressCount > 1)
            progressCount -= 1;
          else
            defaultBackPressed(context);
        });
      },
      childs: <Widget>[
        Expanded(child: createPage()),
      ],
    );
  }
}
