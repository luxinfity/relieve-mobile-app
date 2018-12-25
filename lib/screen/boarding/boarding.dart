import 'package:flutter/material.dart';
import '../../res/image.dart';

class BoadingPage extends StatelessWidget {
    final String title;

    BoadingPage({Key key, this.title}) : super(key: key);

    @override
    Widget build(BuildContext context) {        
        return Scaffold(
            appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
                title: Text(title),
            ),
            body: Column(
                children: <Widget>[
                    Image.network(
                        RemoteImage.boardingHome,                                             
                    ),
                ],
            ),
        );
    }
}