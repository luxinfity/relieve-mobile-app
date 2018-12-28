import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

import '../../res/res.dart';
import '../../widget/item/title.dart';
import '../walkthrough/walkthrough.dart';

class BoardingLogin extends StatelessWidget {
    final String title;

    BoardingLogin({Key key, this.title}) : super(key: key);

    void onBackPressed(BuildContext context) {
        Navigator.pop(context);
    }

    void onLoginClick(BuildContext context) {
        Navigator.push(context, MaterialPageRoute(
			builder: (context) => WalkthroughPage(title: 'Alif',)
		));
    }

    Widget createImageWidget(BuildContext context) {
        if (Theme.of(context).platform == TargetPlatform.iOS) {
            // handle screen too big, in iphone x
            return  SizedBox(
                child: Image.network(
                    RemoteImage.boardingLogin,
                    height: 360,
                ),
            );
        } else {
            return  SizedBox(
                child: Image.network(
                    RemoteImage.boardingLogin,
                ),
            );
        }
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
                        padding: EdgeInsets.only(
                            left: Dimen.x8
                        ),
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
                                createImageWidget(context),
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
                                        bottom: Dimen.x16,
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
                                        top: Dimen.x8,
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
                                        onPressed: () => onLoginClick(context),
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
