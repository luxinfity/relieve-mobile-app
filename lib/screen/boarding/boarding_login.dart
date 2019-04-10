import "package:flutter/material.dart";
import "package:relieve_app/app_config.dart";
import "package:relieve_app/res/res.dart";
import "package:relieve_app/screen/walkthrough/walkthrough.dart";
import "package:relieve_app/service/service.dart";
import "package:relieve_app/utils/preference_utils.dart" as pref;
import "package:relieve_app/widget/item/standard_button.dart";
import "package:relieve_app/widget/item/title.dart";
import "package:relieve_app/widget/loading_dialog.dart";
import "package:relieve_app/widget/relieve_scaffold.dart";
import 'package:relieve_app/widget/snackbar.dart';

import 'package:relieve_app/app_container.dart';

class BoardingLoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BoardingLoginScreenState();
  }
}

class BoardingLoginScreenState extends State {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _usernameFocus = FocusNode();
  final _passwordFocus = FocusNode();

  var isFormEmpty = false;
  var isWrongCredential = false;
  var passwordVisible = false;

  @override
  void initState() {
    super.initState();

    NotificationController.startListen(() => context, (map) {
      showDialog(context: context, builder: (context) => Text('Hello'));
    });
  }

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

      showLoadingDialog(context);

      final tokenResponse = await BakauApi(AppConfig.of(context)).login(
        usernameController.text,
        passwordController.text,
      );

      dismissLoadingDialog(context);

      if (tokenResponse?.status == REQUEST_SUCCESS) {
        pref.setToken(tokenResponse.content.token);
        pref.setRefreshToken(tokenResponse.content.refreshToken);
        pref.setExpireIn(tokenResponse.content.expiresIn);
        pref.setUsername(usernameController.text);
        onLoginSuccess();
      } else {
        showSnackBar(context, "Ups! Username atau password salah",
            buttonText: "Mengerti");
        setState(() {
          isWrongCredential = true;
        });
      }
    }
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
                text: "Login",
                buttonClick: () => onLoginClick(),
                backgroundColor: AppColor.colorPrimary,
              ),
              Container(height: Dimen.x16),
            ],
          ),
        ),
      ],
    );
  }

  String getErrorUsername() {
    if (isFormEmpty && usernameController.text.isEmpty)
      return "Silahkan diisi dulu";
    else if (isWrongCredential)
      return "Username atau Password salah";
    else
      return null;
  }

  String getErrorPassword() {
    if (isFormEmpty && passwordController.text.isEmpty)
      return "Silahkan diisi dulu";
    else if (isWrongCredential)
      return "Username atau Password salah";
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
          labelText: "Password",
          alignLabelWithHint: true,
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
          errorText: getErrorPassword(),
        ),
        controller: passwordController,
        obscureText: !passwordVisible,
        maxLines: 1,
        focusNode: _passwordFocus,
        textInputAction: TextInputAction.done,
        onFieldSubmitted: (term) {
          onLoginClick();
        },
      ),
    );
  }

  Container buildFormUsername() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: Dimen.x16, right: Dimen.x16),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: "Username",
          alignLabelWithHint: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimen.x6),
          ),
          errorText: getErrorUsername(),
        ),
        controller: usernameController,
        maxLines: 1,
        focusNode: _usernameFocus,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (term) {
          _usernameFocus.unfocus();
          setState(() {
            isWrongCredential = false;
          }); // trigger re render
          FocusScope.of(context).requestFocus(_passwordFocus);
        },
      ),
    );
  }

  Row buildForgotPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FlatButton(
          child: Text(
            "Forgot Password?",
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
        title: "Masuk", subtitle: "Bersiap untuk jelajahi aplikasi");
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
