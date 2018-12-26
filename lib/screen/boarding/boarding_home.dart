import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../res/color.dart';
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
                Container(
                    color: AppColor.colorPrimary,
                    height: padding.top,
                ),            
                ListView (
                    padding: EdgeInsets.only(
                        left: padding.left,
                        right: padding.right,
                        bottom: padding.bottom
                    ),
                    shrinkWrap: true,
                    children: <Widget>[
                        ThemedTitle(
                            title: "Home sweet home",
                            subtitle: ""
                        ),
                        Image.network(
                            RemoteImage.boardingHome,
                        ),
                        RaisedButton(
                            child: Text('Login Now'),
                            elevation: 0.5,
                            highlightElevation: 0.5,

                            onPressed: () {

                            },
                        ),
                        RaisedButton.icon(
                            icon: SvgPicture.asset('images/google.svg'),
                            label: Text('Sign In With Google'),
                            elevation: 0.5,
                            highlightElevation: 0.5,

                            onPressed: () {

                            },
                        ),
                        Row (
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                Text('Don’t have an account ?'),
                                FlatButton(
                                    child: Text('Register Here'),
                                    onPressed: () {

                                    },
                                )
                            ],
                        ),
                    ],
                )
            ],
        ),
    );
    // return Scaffold (
    //     // appBar: AppBar(
    //     //     title: Text('alif'),
    //     // ),
    //     body: SafeArea(
    //         child: ListView(

    //             children: <Widget>[

    //             ],
    //         ),
    //     )
    // );
    }
}
