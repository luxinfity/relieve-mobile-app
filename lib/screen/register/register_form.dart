import 'package:flutter/material.dart';
import 'package:relieve_app/widget/item/title.dart';

class RegisterFormAccount extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterFormAccountState();
  }
}

class RegisterFormAccountState extends State<RegisterFormAccount> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ThemedTitle(
          title: 'Akun',
          subtitle: 'Gunakan username kesukaan mu',
        )
      ],
    );
  }
}

class RegisterFormProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterFormProfileState();
  }
}

class RegisterFormProfileState extends State<RegisterFormProfile> {


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
