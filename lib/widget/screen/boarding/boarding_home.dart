import 'package:flutter/material.dart';
import 'package:relieve_app/datamodel/user.dart';
import 'package:relieve_app/res/res.dart';
import 'package:relieve_app/service/service.dart';
import 'package:relieve_app/utils/preference_utils.dart';
import 'package:relieve_app/widget/common/bottom_modal.dart';
import 'package:relieve_app/widget/common/loading_dialog.dart';
import 'package:relieve_app/widget/common/relieve_scaffold.dart';
import 'package:relieve_app/widget/common/standard_button.dart';
import 'package:relieve_app/widget/common/title.dart';
import 'package:relieve_app/widget/screen/boarding/boarding_login.dart';
import 'package:relieve_app/widget/screen/boarding/components/boarding_register_here.dart';
import 'package:relieve_app/widget/screen/register/register.dart';
import 'package:relieve_app/widget/screen/walkthrough/walkthrough.dart';

class BoardingHomeScreen extends StatelessWidget {
  BoardingHomeScreen({Key key}) : super(key: key);

  void goToMainPage(BuildContext context) async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (builder) => WalkthroughScreen()),
      (_) => false, // clean all back stack
    );
  }

  void goToRegisterPage(BuildContext context, User user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (builder) => RegisterScreen(
              progressCount: 2,
              initialData: User(email: user.email, fullName: user.fullName),
            ),
      ),
    );
  }

  /// if (username exist) go to home page
  /// else if (email exist) go to register
  /// else login failed
  void googleButtonClicked(BuildContext context) async {
    RelieveLoadingDialog.show(context);
    var user = await FirebaseAuthHelper.instance.googleLoginWrap();
    RelieveLoadingDialog.dismiss(context);

    if (user != null && user.username != null) {
      // login success
      PreferenceUtils.setLogin(true);
      goToMainPage(context);
    } else if (user != null && user.email.isNotEmpty) {
      goToRegisterPage(context, user);
    } else {
      RelieveBottomModal.create(context, <Widget>[
        Container(height: Dimen.x21),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimen.x16),
          child: Text(
            'Otentikasi Google tidak bisa digunakan, Silahkan gunakan metode lain',
            style: CircularStdFont.book.getStyle(size: Dimen.x16),
          ),
        ),
      ]);
    }
  }

  void loginButtonClicked(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => BoardingLoginScreen()));
  }

  void registerButtonClicked(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterScreen(),
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
          svgIcon: LocalImage.icGoogle,
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
