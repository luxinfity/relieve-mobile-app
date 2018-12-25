import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../res/image.dart';
import '../../res/color.dart';

class BoadingPage extends StatelessWidget {
    final String title;

    BoadingPage({Key key, this.title}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
            statusBarColor: AppColor.colorPrimaryDark
        ));
        return Scaffold (            
            body: SafeArea(
                child: ListView(
                    children: <Widget>[                        
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
                        )
                    ],
                ),
            ) 
        );
    }
}