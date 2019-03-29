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

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _passwordConfirmFocus = FocusNode();

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
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimen.x6),
                    ),
                  ),
                  focusNode: _emailFocus,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (term){
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
                  decoration: InputDecoration(
                    labelText: "Username",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimen.x6),
                    ),
                  ),
                  focusNode: _usernameFocus,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (term){
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
                  obscureText: passwordVisible,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimen.x6),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() => passwordVisible = !passwordVisible);
                      },
                    ),
                  ),
                  focusNode: _passwordFocus,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (term){
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
                  obscureText: passwordVisible,
                  decoration: InputDecoration(
                    labelText: "Ketikkan Kembali Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimen.x6),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
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
          buttonClick: widget.onNextClick,
          backgroundColor: AppColor.colorPrimary,
        ),
        Container(
          height: Dimen.x16 + safePadding.bottom,
        )
      ],
    );
  }
}
