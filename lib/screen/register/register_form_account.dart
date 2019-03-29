import 'package:email_validator/email_validator.dart';
import "package:flutter/material.dart";
import "package:relieve_app/res/res.dart";
import "package:relieve_app/widget/item/standard_button.dart";
import "package:relieve_app/widget/item/title.dart";

class RegisterFormAccount extends StatefulWidget {
  final VoidCallback onNextClick;

  const RegisterFormAccount({Key key, this.onNextClick}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RegisterFormAccountState();
  }
}

class RegisterFormAccountState extends State<RegisterFormAccount> {
  bool passwordVisible = false;

  var isFormValid = true;
  var isUsernameValid = true;
  var isEmailValid = true;
  var isPasswordValid = true;
  var isPasswordMatch = true;

  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _passwordConfirmFocus = FocusNode();

  void onSaveClick() {
    setState(() {
      isUsernameValid = _usernameController.text.length >= 4;
      isEmailValid = EmailValidator.validate(_emailController.text);
      isPasswordValid = _passwordController.text.length >= 5;
      isPasswordMatch =
          _passwordController.text == _confirmPasswordController.text;

      isFormValid = ![
        _emailController,
        _usernameController,
        _passwordController,
        _confirmPasswordController
      ].any((controller) => controller.text.isEmpty);

      if (isFormValid && isEmailValid && isPasswordValid && isPasswordMatch) {
        widget.onNextClick();
      }
    });
  }

  String getErrorText(TextEditingController controller) {
    if (controller.text.isEmpty && !isFormValid) {
      return "Silahkan diisi dulu";
    } else if (!isEmailValid && controller == _emailController) {
      return "Format email tidak valid";
    } else if (!isUsernameValid && controller == _usernameController) {
      return "Panjang username minimal 4 huruf";
    } else if (!isPasswordValid && controller == _passwordController) {
      return "Panjang password minimal 5 huruf";
    } else if (!isPasswordMatch && controller == _confirmPasswordController) {
      return "Masukkan password yang sama";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets safePadding = MediaQuery.of(context).padding;
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            padding: safePadding.copyWith(top: 0),
            children: <Widget>[
              ThemedTitle(
                title: "Akun",
                subtitle: "Gunakan username kesukaan mu",
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: Dimen.x8,
                  bottom: Dimen.x6,
                  left: Dimen.x16,
                  right: Dimen.x16,
                ),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    errorText: getErrorText(_emailController),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimen.x6),
                    ),
                  ),
                  focusNode: _emailFocus,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (term) {
                    _emailFocus.unfocus();
                    FocusScope.of(context).requestFocus(_usernameFocus);
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: Dimen.x8,
                  bottom: Dimen.x6,
                  left: Dimen.x16,
                  right: Dimen.x16,
                ),
                child: TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: "Username",
                    errorText: getErrorText(_usernameController),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimen.x6),
                    ),
                  ),
                  focusNode: _usernameFocus,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (term) {
                    _usernameFocus.unfocus();
                    FocusScope.of(context).requestFocus(_passwordFocus);
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: Dimen.x8,
                  bottom: Dimen.x6,
                  left: Dimen.x16,
                  right: Dimen.x16,
                ),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: !passwordVisible,
                  decoration: InputDecoration(
                    labelText: "Password",
                    errorText: getErrorText(_passwordController),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimen.x6),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() => passwordVisible = !passwordVisible);
                      },
                    ),
                  ),
                  focusNode: _passwordFocus,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (term) {
                    _usernameFocus.unfocus();
                    FocusScope.of(context).requestFocus(_passwordConfirmFocus);
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: Dimen.x8,
                  bottom: Dimen.x6,
                  left: Dimen.x16,
                  right: Dimen.x16,
                ),
                child: TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: !passwordVisible,
                  decoration: InputDecoration(
                    labelText: "Ketikkan Kembali Password",
                    errorText: getErrorText(_confirmPasswordController),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimen.x6),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() => passwordVisible = !passwordVisible);
                      },
                    ),
                  ),
                  focusNode: _passwordConfirmFocus,
                  textInputAction: TextInputAction.done,
                ),
              ),
            ],
          ),
        ),
        StandardButton(
          text: "Simpan",
          buttonClick: onSaveClick,
          backgroundColor: AppColor.colorPrimary,
        ),
        Container(
          height: Dimen.x16 + safePadding.bottom,
        )
      ],
    );
  }
}
