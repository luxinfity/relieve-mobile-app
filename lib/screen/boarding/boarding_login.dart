import 'package:flutter/material.dart';

import '../../res/res.dart';
import '../../widget/item/title.dart';
import '../../widget/item/standard_button.dart';
import '../../widget/relieve_scaffold.dart';
import '../boarding/boarding_register.dart';
import '../boarding/components/boarding_register_here.dart';
import '../walkthrough/walkthrough.dart';
import '../../network/network.dart';
import '../../network/service/base.dart';

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

  void onLoginSuccess() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (builder) => WalkthroughScreen()),
      (_) => false, // clean all back stack
    );
  }

  void onLoginClick(BuildContext context) async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      setState(() {
        isFormEmpty = true;
      });
    } else {
      setState(() {
        isFormEmpty = false;
        isWrongCredential = false;
      });

      final tokenResponse = await BakauApi.login(
        usernameController.text,
        passwordController.text,
      );

      if (tokenResponse.status == REQUEST_SUCCESS)
        onLoginSuccess();
      else
        setState(() {
          isWrongCredential = true;
        });
    }
  }

  void registerButtonClicked(BuildContext context) {
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
              buildImage(context),
              buildFormUsername(),
              buildFormPassword(),
              buildForgotPassword(),
              StandardButton(
                text: 'Login',
                buttonClick: () => onLoginClick(context),
                backgroundColor: AppColor.colorPrimary,
              ),
              buildRegisterHere(context)
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
        top: Dimen.x6,
        left: Dimen.x16,
        right: Dimen.x16,
        bottom: Dimen.x16,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Password',
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
        controller: passwordController,
        obscureText: passwordVisible,
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
          errorText: getErrorPassword(),
        ),
        controller: usernameController,
        maxLines: 1,
      ),
    );
  }

  Padding buildRegisterHere(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: RegisterHere(
        onClick: () => registerButtonClicked(context),
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
        title: "Login Now", subtitle: "Please login to continue using our app");
  }

  Widget buildImage(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      // handle screen too big, in iphone x
      return SizedBox(
        child: RemoteImage.boardingLogin.toImage(height: 360),
      );
    } else {
      return SizedBox(child: RemoteImage.boardingLogin.toImage());
    }
  }
}
