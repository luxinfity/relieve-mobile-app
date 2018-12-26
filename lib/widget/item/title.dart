import 'package:flutter/material.dart';

import '../../res/font.dart';

class ThemedTitle extends StatelessWidget {
    final String title;
    final String subtitle;

    ThemedTitle({this.title, this.subtitle});

    @override
    Widget build(BuildContext context) {
        return Column(    
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                Text(
                    title,
                    style: CircularStdFont.getFont(
                        style: CircularStdFontStyle.Bold, 
                        size: 22
                    )
                ),
                Text(subtitle),
            ],
        );
    }
}