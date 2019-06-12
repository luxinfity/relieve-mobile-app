import 'package:flutter/material.dart';
import 'package:relieve_app/res/export.dart';
import 'package:relieve_app/service/firebase/firebase_auth_helper.dart';
import 'package:relieve_app/widget/common/loading_dialog.dart';
import 'package:relieve_app/widget/common/relieve_scaffold.dart';
import 'package:relieve_app/widget/common/relieve_snackbar.dart';
import 'package:relieve_app/widget/common/standard_button.dart';
import 'package:relieve_app/widget/common/title.dart';
import 'package:relieve_app/widget/screen/walkthrough/walkthrough_screen.dart';

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

  void onLoginSuccess(String username) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (builder) => WalkthroughScreen()),
      (_) => false, // clean all back stack
    );
  }

  void onLoginClick() async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      if (!mounted) return;
      setState(() {
        isFormEmpty = true;
      });
    } else {
      if (!mounted) return;
      setState(() {
        isFormEmpty = false;
        isWrongCredential = false;
      });

      RelieveLoadingDialog.show(context);
      final isSuccess = await FirebaseAuthHelper.get()
          .login(usernameController.text, passwordController.text);
      RelieveLoadingDialog.dismiss(context);

      if (isSuccess) {
        onLoginSuccess(usernameController.text);
      } else {
        RelieveSnackBar.show(context, 'Ups! Username atau password salah',
            buttonText: 'Mengerti');

        if (!mounted) return;
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
                text: 'Login',
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
      return 'Silahkan diisi dulu';
    else if (isWrongCredential)
      return 'Username atau Password salah';
    else
      return null;
  }

  String getErrorPassword() {
    if (isFormEmpty && passwordController.text.isEmpty)
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
          labelText: 'Username',
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
