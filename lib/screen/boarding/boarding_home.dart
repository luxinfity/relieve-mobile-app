import 'package:flutter/material.dart';

import '../../res/res.dart';
import '../../widget/item/title.dart';
import '../../widget/relieve_scaffold.dart';
import '../../widget/item/standard_button.dart';
import '../walkthrough/walkthrough.dart';
import 'components/boarding_register_here.dart';
import 'boarding_login.dart';
import 'boarding_register.dart';

class BoardingHomeScreen extends StatelessWidget {
  BoardingHomeScreen({Key key}) : super(key: key);

  void loginButtonClicked(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => BoardingLoginScreen()));
  }

  void googleButtonClicked(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (builder) => WalkthroughScreen()),
      (_) => false, // clean all back stack
    );
  }

  void registerButtonClicked(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => BoardingRegisterScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return RelieveScaffold(
      childs: <Widget>[
        buildTitle(),
        buildImage(),
        StandardButton(
          key: Key('home-login'),
          text: 'Login Now',
          backgroundColor: AppColor.colorPrimary,
          buttonClick: () => loginButtonClicked(context),
        ),
        StandardButton(
          key: Key('home-google-sign-in'),
          text: 'Sign In With Google',
          svgIcon: LocalImage.ic_google,
          backgroundColor: AppColor.colorDanger,
          buttonClick: () => googleButtonClicked(context),
        ),
        buildRegister(context),
      ],
    );
  }

  Padding buildRegister(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimen.x24, bottom: Dimen.x24),
      child: RegisterHere(
        onClick: () => registerButtonClicked(context),
      ),
    );
  }

  Expanded buildImage() {
    return Expanded(
      child: RemoteImage.boardingHome.toImage(),
    );
  }

  Widget buildTitle() {
    return Padding(
      padding: EdgeInsets.only(top: 12, bottom: 18),
      child: ThemedTitle(title: 'Home sweet home'),
    );
  }
}
