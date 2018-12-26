import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../res/color.dart';
import '../../res/font.dart';
import '../../res/image.dart';
import '../../widget/item/title.dart';

class BoadingPage extends StatelessWidget {
    final String title;

    BoadingPage({Key key, this.title}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
        final EdgeInsets padding = MediaQuery.of(context).padding;
        return Scaffold(
            body: Column(
                children: <Widget>[
                    Container( // status bar color
                        color: AppColor.colorPrimary,
                        height: padding.top,
                    ),
                    Container(height: 12),
                    ThemedTitle(
                        title: "Home sweet home",
                        subtitle: ""
                    ),
                    Container(height: 18),
                    Expanded(
                        child: Image.network(
                            RemoteImage.boardingHome,
                        ),
                    ),
                    Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(
                            top: 21,
                            left: 16,
                            right: 16
                        ),
                        child: RaisedButton(
                            child: Text('Login Now',
                                style: CircularStdFont.getFont(
                                    size: 14,
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
                                top: 13,
                                bottom: 13,
                            ),
                            onPressed: () {

                            },
                        ),
                    ),
                    Container(height: 8),
                    Container(
                        margin: EdgeInsets.only(
                            top: 6,
                            left: 16,
                            right: 16
                        ),
                        child: RaisedButton(
                            child: Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                    Expanded(
                                        flex: 1,
                                        child: SvgPicture.asset('images/google.svg', height: 20),
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: Text('Sign In With Google',
                                            style: CircularStdFont.getFont(
                                                size: 14,
                                                style: CircularStdFontStyle.Medium
                                            ).apply(
                                                color: Colors.white
                                            ),
                                        )
                                    )
                                ],
                            ),
                            color: AppColor.colorDanger,
                            elevation: 1,
                            highlightElevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)
                            ),
                            padding: EdgeInsets.only(
                                top: 13,
                                bottom: 13,
                            ),
                            onPressed: () {

                            },
                        ),
                    ),
                    Container(height: 16),
                    Row (
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                            Text('Don’t have an account ?',
                                style: CircularStdFont.getFont(
                                    size: 14,
                                    style: CircularStdFontStyle.Book
                                ).apply(
                                    color: AppColor.colorTextGrey
                                )
                            ),
                            FlatButton(
                                child: Text('Register Here',
                                    style: CircularStdFont.getFont(
                                        size: 14,
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
                    Container(height: 24),
                ],
            ),
        );
    }
}
