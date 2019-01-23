import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../res/res.dart';
import '../../widget/item/title.dart';
import '../../widget/item/standard_button.dart';
import '../../widget/relieve_scaffold.dart';
import '../boarding/boarding_register.dart';
import '../boarding/components/boarding_register_here.dart';
import '../walkthrough/walkthrough.dart';

class BoardingLoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BoardingLoginScreenState();
  }
}

class BoardingLoginScreenState extends State {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  var formIsEmpty = false;

  void onLoginSuccess() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (builder) => WalkthroughScreen()),
      (_) => false, // clean all back stack
    );
  }

  void onLoginClick(BuildContext context) {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      setState(() {
        formIsEmpty = true;
      });
    } else {
      setState(() {
        formIsEmpty = false;
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
          errorText: formIsEmpty && passwordController.text.isEmpty
              ? 'Silahkan di isi dulu'
              : null,
        ),
        controller: passwordController,
        obscureText: true,
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
          errorText: formIsEmpty && usernameController.text.isEmpty
              ? 'Silahkan di isi dulu'
              : null,
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
