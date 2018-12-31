import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../res/res.dart';
import '../../widget/item/title.dart';
import '../walkthrough/walkthrough.dart';
import 'boarding_login.dart';
import 'boarding_register.dart';

class BoardingHome extends StatelessWidget {

    BoardingHome({Key key}) : super(key: key);

	void loginButtonClicked(BuildContext context) {
		Navigator.push(context, MaterialPageRoute(
			builder: (context) => BoardingLogin()
		));
	}

	void googleButtonClicked(BuildContext context) {
		Navigator.push(context, MaterialPageRoute(
			builder: (context) => WalkthroughPage(title: 'Alif',)
		));
	}

	void registerButtonClicked(BuildContext context) {
		Navigator.push(context, MaterialPageRoute(
			builder: (context) => BoardingRegister()
		));
	}

    @override
    Widget build(BuildContext context) {
        final EdgeInsets padding = MediaQuery.of(context).padding;
        return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
                children: <Widget>[
                    Container( // status bar color
                        color: AppColor.colorPrimary,
                        height: padding.top,
                    ),
                    Container(height: Dimen.x12),
                    ThemedTitle(
                        title: "Home sweet home",
                        subtitle: ""
                    ),
                    Container(height: Dimen.x18),
                    Expanded(
                        child: Image.network(
                            RemoteImage.boardingHome,
                        ),
                    ),
                    Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(
                            top: Dimen.x21,
                            left: Dimen.x16,
                            right: Dimen.x16
                        ),
                        child: RaisedButton(
                            key: Key('home-login'),
                            child: Text('Login Now',
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
                            onPressed: () => loginButtonClicked(context),
                        ),
                    ),
                    Container(height: Dimen.x8),
                    Container(
                        margin: EdgeInsets.only(
                            top: Dimen.x6,
                            left: Dimen.x16,
                            right: Dimen.x16
                        ),
                        child: RaisedButton(
                            child: Row(
                                children: <Widget>[
                                    Expanded(
                                        flex: 1,
                                        child: SvgPicture.asset('images/google.svg', height: 20),
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: Text('Sign In With Google',
                                            style: CircularStdFont.getFont(
                                                size: Dimen.x14,
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
                                top: Dimen.x14,
                                bottom: Dimen.x14,
                            ),
                            onPressed: () => googleButtonClicked(context),
                        ),
                    ),
                    Container(height: Dimen.x16),
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
                                onPressed: () => registerButtonClicked(context),
                            )
                        ],
                    ),
                    Container(height: Dimen.x24),
                ],
            ),
        );
    }
}
