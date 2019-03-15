import 'package:flutter/material.dart';
import 'package:relieve_app/res/res.dart';
import 'package:relieve_app/widget/item/standard_button.dart';
import 'package:relieve_app/widget/item/title.dart';

class RegisterFormProfile extends StatefulWidget {
  final VoidCallback onNextClick;

  const RegisterFormProfile({Key key, this.onNextClick}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RegisterFormProfileState();
  }
}

class RegisterFormProfileState extends State<RegisterFormProfile> {
  bool passwordVisible = false;

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
                  top: Dimen.x8,
                  bottom: Dimen.x6,
                  left: Dimen.x16,
                  right: Dimen.x16,
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimen.x6),
                    ),
                  ),
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
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimen.x6),
                    ),
                  ),
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
                    labelText: 'Password',
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
                    labelText: 'Ketikkan Kembali Password',
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
                ),
              ),
            ],
          ),
        ),
        StandardButton(
          text: 'Lanjut',
          buttonClick: widget.onNextClick,
          backgroundColor: AppColor.colorPrimary,
        ),
        Container(
          height: safePadding.bottom,
        )
      ],
    );
  }
}
