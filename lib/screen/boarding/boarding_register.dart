import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../res/res.dart';
import '../../widget/item/title.dart';

class BoardingRegister extends StatefulWidget {

    BoardingRegister({Key key}) : super(key: key);

    @override
    State<StatefulWidget> createState() {
        return BoardingRegisterState();
    } 
}


class BoardingRegisterState extends State {
    var steps = 0;

    void onBackPressed(BuildContext context) {
        Navigator.pop(context);
    }

    void onButtonClick(BuildContext context) {
        setState(() {
            steps = 1;
        });
    }

    Widget createTitle() {
        if (steps == 0) {
            return ThemedTitle(
                title: "Cukup isi data dibawah",
                subtitle: ""
            );
        } else {
            return ThemedTitle(
                title: "Beritahu kami mengenai kamu",
                subtitle: ""
            );
        }
    }

    Widget createButton() {
        if (steps == 0) {
            return Text('Lanjut',
                style: CircularStdFont.getFont(
                    size: Dimen.x14,
                    style: CircularStdFontStyle.Medium
                ).apply(
                    color: Colors.white
                ),
            );
        } else {
            return Text('Daftar',
                style: CircularStdFont.getFont(
                    size: Dimen.x14,
                    style: CircularStdFontStyle.Medium
                ).apply(
                    color: Colors.white
                ),
            );
        }
    }

    List<Widget> createForm() {
        if (steps == 0) {            
            return <Widget>[
                Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                        left: Dimen.x24,
                        right: Dimen.x24
                    ),
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
                    margin: EdgeInsets.only(
                        top: Dimen.x6,
                        left: Dimen.x24,
                        right: Dimen.x24
                    ),
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
                    margin: EdgeInsets.only(
                        left: Dimen.x24,
                        right: Dimen.x24
                    ),
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
                    margin: EdgeInsets.only(
                        top: Dimen.x6,
                        left: Dimen.x24,
                        right: Dimen.x24
                    ),
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
        final EdgeInsets padding = MediaQuery.of(context).padding;

        List<Widget> children = <Widget>[
            Container( // status bar color
                color: AppColor.colorPrimary,
                height: padding.top,
            ),
            IconButton(
                padding: EdgeInsets.only(
                    left: Dimen.x8
                ),
                icon: SvgPicture.asset('images/back_arrow.svg', height: 26),
                onPressed: () => onBackPressed(context),
            ),
            createTitle(),
            
            Expanded(
                child: Container(),
            ),
            Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                    top: Dimen.x8,
                    left: Dimen.x21,
                    right: Dimen.x21,
                    bottom: Dimen.x28
                ),
                child: RaisedButton(
                    child: createButton(),
                    color: AppColor.colorPrimary,
                    elevation: 1,
                    highlightElevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)
                    ),
                    padding: EdgeInsets.only(
                        top: Dimen.x16,
                        bottom: Dimen.x16,
                    ),
                    onPressed: () => onButtonClick(context),
                ),
            ),
        ];

        // add forms
        children.insertAll(3, createForm());

        return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Container( // status bar color
                        color: AppColor.colorPrimary,
                        height: padding.top,
                    ),
                    IconButton(
                        padding: EdgeInsets.only(
                            left: Dimen.x8
                        ),
                        icon: SvgPicture.asset('images/back_arrow.svg', height: 26),
                        onPressed: () => onBackPressed(context),
                    ),
                ],
            ),
        );
    }
}