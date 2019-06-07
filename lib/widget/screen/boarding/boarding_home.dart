import 'package:flutter/material.dart';
import 'package:relieve_app/res/res.dart';
import 'package:relieve_app/service/service.dart';
import 'package:relieve_app/utils/common_utils.dart';
import 'package:relieve_app/widget/common/relieve_scaffold.dart';
import 'package:relieve_app/widget/common/standard_button.dart';
import 'package:relieve_app/widget/common/title.dart';
import 'package:relieve_app/widget/screen/boarding/boarding_login.dart';
import 'package:relieve_app/widget/screen/boarding/components/boarding_register_here.dart';
import 'package:relieve_app/widget/screen/register/register.dart';

class BoardingHomeScreen extends StatelessWidget {
  BoardingHomeScreen({Key key}) : super(key: key);

  void loginButtonClicked(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => BoardingLoginScreen()));
  }

  void doGoogleLogin(BuildContext context, String email, String token) async {
//    showLoadingDialog(context);

//    final tokenResponse =
//        await Api.get().setProvider(BakauProvider()).login(email, token);
//
//    dismissLoadingDialog(context);
//
//    if (tokenResponse?.status == REQUEST_SUCCESS) {
//      pref.setToken(tokenResponse.content.token);
//      pref.setRefreshToken(tokenResponse.content.refreshToken);
//      pref.setExpireIn(tokenResponse.content.expiresIn);
//      pref.setUsername(email);
//      Navigator.pushAndRemoveUntil(
//        context,
//        MaterialPageRoute(builder: (builder) => WalkthroughScreen()),
//        (_) => false, // clean all back stack
//      );
//    } else {
//      createRelieveBottomModal(context, <Widget>[
//        Container(height: Dimen.x21),
//        Padding(
//          padding: const EdgeInsets.symmetric(horizontal: Dimen.x16),
//          child: Text(
//            'Google login sedang tidak bisa digunakan, Gunakan metode login yang lain',
//            style: CircularStdFont.book.getStyle(size: Dimen.x16),
//          ),
//        ),
//      ]);
//    }
  }

  void googleButtonClicked(BuildContext context) async {
    try {
      var token = await FirebaseAuthHelper.instance.googleLoginWrap();
//      final account = await googleSignInScope.signIn();
//      if (account.email.isNotEmpty) {
//        // final idToken = (await account.authentication).idToken;
//        setGoogleId(account.id);
//
//        // check, has user already registered before
//        final checkResponse = await Api.get()
//            .setProvider(BakauProvider())
//            .checkUser(UserCheckIdentifier.email, account.email);
//
//        if (checkResponse?.status == REQUEST_SUCCESS &&
//            checkResponse?.content?.isExsist == true) {
//          doGoogleLogin(context, account.email, account.id);
//        } else {
//          Navigator.push(
//            context,
//            MaterialPageRoute(
//              builder: (builder) => RegisterScreen(
//                    progressCount: 2,
//                    initialData:
//                        Account(account.email, account.email, account.id),
//                  ),
//            ),
//          );
//        }
//      }
    } catch (error) {
      debugLog(BoardingHomeScreen).severe(error);
    }
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
