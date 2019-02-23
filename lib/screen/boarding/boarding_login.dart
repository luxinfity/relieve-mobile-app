import 'package:flutter/material.dart';
import 'package:relieve_app/app_config.dart';
import 'package:relieve_app/utils/top_snackbar.dart';

import '../../res/res.dart';
import '../../widget/item/title.dart';
import '../../widget/item/standard_button.dart';
import '../../widget/relieve_scaffold.dart';
import '../boarding/boarding_register.dart';
import '../boarding/components/boarding_register_here.dart';
import '../walkthrough/walkthrough.dart';
import '../../service/service.dart';
import '../../service/source/api/config.dart';
import '../../utils/preference_utils.dart' as pref;

class BoardingLoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BoardingLoginScreenState();
  }
}

class BoardingLoginScreenState extends State {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  var isFormEmpty = false;
  var isWrongCredential = false;
  var passwordVisible = false;

  var snackbar;

  void onLoginSuccess() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (builder) => WalkthroughScreen()),
      (_) => false, // clean all back stack
    );
  }

  void onLoginClick() async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      setState(() {
        isFormEmpty = true;
      });
    } else {
      setState(() {
        isFormEmpty = false;
        isWrongCredential = false;
      });

      final tokenResponse = await BakauApi(AppConfig.of(context)).login(
        usernameController.text,
        passwordController.text,
      );

      if (tokenResponse?.status == REQUEST_SUCCESS) {
        await pref.setToken(tokenResponse.content.token);
        await pref.setRefreshToken(tokenResponse.content.refreshToken);
        await pref.setExpireIn(tokenResponse.content.expiresIn);
        await pref.setUsername(usernameController.text);
        onLoginSuccess();
      } else {
        _showErrorSnackBar();
        setState(() {
          isWrongCredential = true;
        });
      }
    }
  }

  void _showErrorSnackBar() {
    if (snackbar != null) {
      snackbar.dismiss(true);
    }
    snackbar = TopSnackbar.createAction(
        message: "Ups! Username dan password salah",
        button: FlatButton(
          onPressed: () => snackbar.dismiss(true),
          child: Text(
            "Mengerti",
            style: TextStyle(color: Colors.red),
          ),
        ));
    snackbar.show(context);
  }

  void registerButtonClicked() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => BoardingRegisterScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;

    return RelieveScaffold(
      crossAxisAlignment: CrossAxisAlignment.start,
      hasBackButton: true,
      childs: <Widget>[
        Expanded(
          child: ListView(
            padding: EdgeInsets.only(left: padding.left, right: padding.right),
            children: <Widget>[
              buildTitle(),
              buildImage(),
              buildFormUsername(),
              buildFormPassword(),
              buildForgotPassword(),
              StandardButton(
                text: 'Login',
                buttonClick: () => onLoginClick(),
                backgroundColor: AppColor.colorPrimary,
              ),
              // buildRegisterHere()
            ],
          ),
        ),
      ],
    );
  }

  String getErrorUsername() {
    if (isFormEmpty && passwordController.text.isEmpty)
      return 'Silahkan diisi dulu';
    else if (isWrongCredential)
      return 'Username atau Password salah';
    else
      return null;
  }

  String getErrorPassword() {
    if (isFormEmpty && usernameController.text.isEmpty)
      return 'Silahkan diisi dulu';
    else if (isWrongCredential)
      return 'Username atau Password salah';
    else
      return null;
  }

  Container buildFormPassword() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        top: Dimen.x16,
        left: Dimen.x16,
        right: Dimen.x16,
        bottom: Dimen.x16,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Password',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimen.x6),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              passwordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() => passwordVisible = !passwordVisible);
            },
          ),
          errorText: getErrorUsername(),
        ),
        textInputAction: TextInputAction.done,
        controller: passwordController,
        obscureText: !passwordVisible,
        maxLines: 1,
      ),
    );
  }

  Container buildFormUsername() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: Dimen.x16, right: Dimen.x16),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Username',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimen.x6),
          ),
          errorText: getErrorPassword(),
        ),
        textInputAction: TextInputAction.next,
        controller: usernameController,
        maxLines: 1,
      ),
    );
  }

  Padding buildRegisterHere() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: RegisterHere(
        onClick: () => registerButtonClicked(),
      ),
    );
  }

  Row buildForgotPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FlatButton(
          child: Text(
            'Forgot Password?',
            style: CircularStdFont.book
                .getStyle(size: Dimen.x14, color: AppColor.colorPrimary),
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  ThemedTitle buildTitle() {
    return ThemedTitle(
        title: 'Masuk', subtitle: 'Bersiap untuk jelajahi aplikasi');
  }

  Widget buildImage() {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      // handle screen too big, in iphone x
      return SizedBox(
        child: RemoteImage.boardingLogin.toImage(height: 336),
      );
    } else {
      return SizedBox(child: RemoteImage.boardingLogin.toImage());
    }
  }
}
