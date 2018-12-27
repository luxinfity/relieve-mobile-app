import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../res/res.dart';
import '../../widget/item/title.dart';

class BoardingLogin extends StatelessWidget {
    final String title;

    BoardingLogin({Key key, this.title}) : super(key: key);

    void onBackPressed(BuildContext context) {
        Navigator.pop(context);
    }

    @override
    Widget build(BuildContext context) {
        final EdgeInsets padding = MediaQuery.of(context).padding;
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
                        icon: SvgPicture.asset('images/back_arrow.svg', height: 26),
                        onPressed: () => onBackPressed(context),
                    ),
                    Expanded(
                        child: ListView (
                            padding: EdgeInsets.only(
                                left: padding.left,
                                right: padding.right
                            ),
                            children: <Widget>[
                                ThemedTitle(
                                    title: "Login Now",
                                    subtitle: "Please login to continue using our app"
                                ),
                                SizedBox(
                                    child: Image.network(
                                        RemoteImage.boardingLogin,
                                    ),
                                    width: double.infinity,
                                ),
                                Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(
                                        left: Dimen.x16,
                                        right: Dimen.x16
                                    ),
                                    child: TextFormField(
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
                                        left: Dimen.x16,
                                        right: Dimen.x16,
                                        bottom: Dimen.x6,
                                    ),
                                    child: TextFormField(
                                        decoration: InputDecoration(
                                            labelText: 'Password',
                                        ),
                                        obscureText: true,
                                        maxLines: 1,
                                    ),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                        FlatButton(
                                            child: Text('Forgot Password?',
                                                style: CircularStdFont.getFont(
                                                    size: Dimen.x14,
                                                    style: CircularStdFontStyle.Book
                                                ).apply(
                                                    color: AppColor.colorPrimary
                                                )
                                            ),
                                            onPressed: () {

                                            },
                                        ),
                                    ],
                                ),
                                Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(
                                        top: Dimen.x6,
                                        left: Dimen.x16,
                                        right: Dimen.x16
                                    ),
                                    child: RaisedButton(
                                        child: Text('Login',
                                            style: CircularStdFont.getFont(
                                                size: Dimen.x14,
                                                style: CircularStdFontStyle.Medium
                                            ).apply(
                                                color: Colors.white
                                            ),
                                        ),
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
                                        onPressed: () {

                                        },
                                    ),
                                ),
                                Container(height: Dimen.x12),
                                Row (
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                        Text('Don’t have an account ?',
                                            style: CircularStdFont.getFont(
                                                size: Dimen.x14,
                                                style: CircularStdFontStyle.Book
                                            ).apply(
                                                color: AppColor.colorTextGrey
                                            )
                                        ),
                                        FlatButton(
                                            child: Text('Register Here',
                                                style: CircularStdFont.getFont(
                                                    size: Dimen.x14,
                                                    style: CircularStdFontStyle.Book
                                                ).apply(
                                                    color: AppColor.colorPrimary
                                                )
                                            ),
                                            onPressed: () {

                                            },
                                        )
                                    ],
                                ),
                            ],
                        ),
                    ),                    
                ],
            ),
        );
    }
}
