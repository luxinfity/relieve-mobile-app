import 'package:flutter/material.dart';

import '../../res/res.dart';
import '../../widget/item/title.dart';
import '../../widget/relieve_scaffold.dart';
import '../boarding/boarding_register.dart';
import '../dashboard/dashboard.dart';

class BoardingLogin extends StatelessWidget {
  final String title;

  BoardingLogin({Key key, this.title}) : super(key: key);

  void onLoginClick(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DashboardScreen()));
  }

  void registerButtonClicked(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BoardingRegister()));
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;

    return RelieveScaffold(
      crossAxisAlignment: CrossAxisAlignment.start,
      hasBackButton: true,
      childs: <Widget>[
        Expanded(
          child: ListView(
            padding: EdgeInsets.only(left: padding.left, right: padding.right),
            children: <Widget>[
              buildTitle(),
              buildImage(context),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: Dimen.x16, right: Dimen.x16),
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
                                style: CircularStdFontStyle.Book)
                            .apply(color: AppColor.colorPrimary)),
                    onPressed: () {},
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                    top: Dimen.x8, left: Dimen.x16, right: Dimen.x16),
                child: RaisedButton(
                  child: Text(
                    'Login',
                    style: CircularStdFont.getFont(
                            size: Dimen.x14, style: CircularStdFontStyle.Medium)
                        .apply(color: Colors.white),
                  ),
                  color: AppColor.colorPrimary,
                  elevation: 1,
                  highlightElevation: 1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  padding: EdgeInsets.only(
                    top: Dimen.x16,
                    bottom: Dimen.x16,
                  ),
                  onPressed: () => onLoginClick(context),
                ),
              ),
              Container(height: Dimen.x12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Don’t have an account ?',
                      style: CircularStdFont.getFont(
                              size: Dimen.x14, style: CircularStdFontStyle.Book)
                          .apply(color: AppColor.colorTextGrey)),
                  FlatButton(
                    child: Text('Register Here',
                        style: CircularStdFont.getFont(
                                size: Dimen.x14,
                                style: CircularStdFontStyle.Book)
                            .apply(color: AppColor.colorPrimary)),
                    onPressed: () => registerButtonClicked(context),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  ThemedTitle buildTitle() {
    return ThemedTitle(
                title: "Login Now",
                subtitle: "Please login to continue using our app");
  }

  Widget buildImage(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      // handle screen too big, in iphone x
      return SizedBox(
        child: RemoteImage.boardingLogin.toImage(height: 360),
      );
    } else {
      return SizedBox(child: RemoteImage.boardingLogin.toImage());
    }
  }
}
