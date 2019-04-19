import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:relieve_app/res/res.dart';
import 'package:relieve_app/widget/common/standard_button.dart';
import 'package:relieve_app/widget/common/title.dart';

class Account {
  final String email;
  final String username;
  final String password;

  Account(this.email, this.username, this.password);
}

typedef AccountFormCallback = void Function(Account account);

class RegisterFormAccount extends StatefulWidget {
  final AccountFormCallback onNextClick;
  final Account initialData;

  const RegisterFormAccount({
    Key key,
    this.onNextClick,
    this.initialData,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RegisterFormAccountState();
  }
}

class RegisterFormAccountState extends State<RegisterFormAccount> {
  bool passwordVisible = false;

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

      if (isEmailValid && isPasswordValid && isPasswordMatch) {
        widget.onNextClick(Account(
          _emailController.text.toLowerCase(),
          _usernameController.text.toLowerCase(),
          _passwordController.text,
        ));
      }
    });
  }

  bool isFormFilled() {
    return ![
      _emailController,
      _usernameController,
      _passwordController,
      _confirmPasswordController
    ].any((controller) => controller.text.isEmpty);
  }

  String getErrorText(TextEditingController controller) {
    if (!isEmailValid && controller == _emailController) {
      return 'Format email tidak valid';
    } else if (!isUsernameValid && controller == _usernameController) {
      return 'Panjang username minimal 4 huruf';
    } else if (!isPasswordValid && controller == _passwordController) {
      return 'Panjang password minimal 5 huruf';
    } else if (!isPasswordMatch && controller == _confirmPasswordController) {
      return 'Masukkan password yang sama';
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _emailController.text = widget.initialData.email;
      _usernameController.text = widget.initialData.username;
      _passwordController.text = widget.initialData.password;
      _confirmPasswordController.text = widget.initialData.password;
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
                title: 'Akun',
                subtitle: 'Gunakan username kesukaan mu',
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: Dimen.x32,
                  bottom: Dimen.x6,
                  left: Dimen.x16,
                  right: Dimen.x16,
                ),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    errorText: getErrorText(_emailController),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimen.x6),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
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
                    labelText: 'Username',
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
                    labelText: 'Password',
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
                    labelText: 'Ketikkan Kembali Password',
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
          text: 'Simpan',
          isEnabled: isFormFilled(),
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
