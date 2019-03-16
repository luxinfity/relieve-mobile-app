import 'package:flutter/material.dart';
import 'package:relieve_app/res/res.dart';
import 'package:relieve_app/screen/boarding/components/boarding_register_here.dart';
import 'package:relieve_app/screen/register/register.dart';
import 'package:relieve_app/screen/walkthrough/walkthrough.dart';
import 'package:relieve_app/widget/item/standard_button.dart';
import 'package:relieve_app/widget/item/title.dart';
import 'package:relieve_app/utils/preference_utils.dart';

class BoardingHomeScreen extends StatelessWidget {
  BoardingHomeScreen({Key key}) : super(key: key);

  void loginButtonClicked(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => BoardingLoginScreen()));
  }

  void googleButtonClicked(BuildContext context) async {
    try {
      final account = await googleSignInScope.signIn();
      if (account.email.isNotEmpty) {
        await setGoogleId(account.id);
        await setUsername(account.email);
        
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => WalkthroughScreen()),
          (_) => false, // clean all back stack
        );
      }
    } catch (error) {
      print(error);
    }
  }

  void registerButtonClicked(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BoardingRegisterScreen(),
      ),
    );
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
      child: ThemedTitle(
        title: 'Selamat datang di Relieve!',
        subtitle: 'Harta yang paling berharga adalah keluarga',
      ),
    );
  }
}
