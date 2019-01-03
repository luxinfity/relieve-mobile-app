import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../res/res.dart';
import '../../widget/item/title.dart';
import '../../widget/item/standard_button.dart';
import '../walkthrough/walkthrough.dart';
import '../../widget/relieve_scaffold.dart';

class BoardingRegister extends StatefulWidget {
  BoardingRegister({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BoardingRegisterState();
  }
}

class BoardingRegisterState extends State {
  var steps = 0;

  void onButtonClick(BuildContext context) {
    if (steps == 0) {
      setState(() => steps = 1);
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WalkthroughPage(
                    title: 'Alif',
                  )));
    }
  }

  Widget createTitle() {
    if (steps == 0) {
      return ThemedTitle(title: "Cukup isi data dibawah", subtitle: "");
    } else {
      return ThemedTitle(title: "Beritahu kami mengenai kamu", subtitle: "");
    }
  }

  Widget createButton() {
    return StandardButton(
      text: steps == 0 ? 'Lanjut' : 'Daftar',
      backgroundColor: AppColor.colorPrimary,
      buttonClick: () => onButtonClick(context),
    );
  }

  List<Widget> createForm() {
    if (steps == 0) {
      return <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: Dimen.x24, right: Dimen.x24),
          child: TextFormField(
            key: Key('emailInput'),
            decoration: InputDecoration(
              labelText: 'Email',
            ),
            maxLines: 1,
          ),
        ),
        Container(
          width: double.infinity,
          margin:
              EdgeInsets.only(top: Dimen.x6, left: Dimen.x24, right: Dimen.x24),
          child: TextFormField(
            key: Key('usernameInput'),
            decoration: InputDecoration(
              labelText: 'Username',
            ),
            maxLines: 1,
          ),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(
            top: Dimen.x6,
            left: Dimen.x24,
            right: Dimen.x24,
          ),
          child: TextFormField(
            key: Key('passwordInput'),
            decoration: InputDecoration(
              labelText: 'Password',
            ),
            obscureText: true,
            maxLines: 1,
          ),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(
            top: Dimen.x6,
            left: Dimen.x24,
            right: Dimen.x24,
            bottom: Dimen.x24,
          ),
          child: TextFormField(
            key: Key('confirmPassInput'),
            decoration: InputDecoration(
              labelText: 'Ketik Ulang Password',
            ),
            obscureText: true,
            maxLines: 1,
          ),
        ),
      ];
    } else {
      return <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: Dimen.x24, right: Dimen.x24),
          child: TextFormField(
            key: Key('nameInput'),
            decoration: InputDecoration(
              labelText: 'Nama Lengkap',
            ),
            maxLines: 1,
          ),
        ),
        Container(
          width: double.infinity,
          margin:
              EdgeInsets.only(top: Dimen.x6, left: Dimen.x24, right: Dimen.x24),
          child: TextFormField(
            key: Key('phoneInput'),
            decoration: InputDecoration(
              prefixText: '+62 ',
              labelText: 'Nomor Telpon',
            ),
            maxLines: 1,
          ),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(
            top: Dimen.x6,
            left: Dimen.x24,
            right: Dimen.x24,
          ),
          child: TextFormField(
            key: Key('dobInput'),
            decoration: InputDecoration(
              labelText: 'Tanggal Lahir',
            ),
            maxLines: 1,
          ),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(
            top: Dimen.x6,
            left: Dimen.x24,
            right: Dimen.x24,
            bottom: Dimen.x24,
          ),
          child: TextFormField(
            key: Key('genderInput'),
            decoration: InputDecoration(
              labelText: 'Gender',
            ),
            maxLines: 1,
          ),
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = <Widget>[
      createTitle(),
      Expanded(
        child: Container(),
      ),
      Padding(
        padding: const EdgeInsets.only(left: Dimen.x32, right: Dimen.x32),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: 'By registering you are accepting our ',
              style: CircularStdFont.getFont(
                      style: CircularStdFontStyle.Book, size: Dimen.x14)
                  .apply(color: AppColor.colorTextBlack),
              children: <TextSpan>[
                TextSpan(
                  text: 'terms and condition',
                  style: CircularStdFont.getFont(
                          style: CircularStdFontStyle.Book, size: Dimen.x14)
                      .apply(color: AppColor.colorPrimary),
                  recognizer: TapGestureRecognizer()..onTap = () {
                    launch('https://github.com/RelieveID/terms-and-conditions/');
                  },
                ),
                TextSpan(text: ' of use')
              ]),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: Dimen.x8, bottom: Dimen.x28),
        child: createButton(),
      ),
    ];

    // add forms
    children.insertAll(1, createForm());

    return RelieveScaffold(
        crossAxisAlignment: CrossAxisAlignment.start,
        hasBackButton: true,
        childs: children);
  }
}
