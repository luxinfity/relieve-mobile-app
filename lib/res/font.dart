import 'package:flutter/material.dart';

enum CircularStdFontStyle {
    Book, Medium, Bold, Black
}

class CircularStdFont {
    static const defaultName = 'CircularStdBook';
    static const fontSize = 12.0;    

    static TextStyle getFont({CircularStdFontStyle style, double size}) {
        switch(style) {
            case CircularStdFontStyle.Medium: 
                return TextStyle(fontFamily: 'CircularStdMedium', fontSize: size, fontWeight: FontWeight.w200);
                break;
            case CircularStdFontStyle.Bold: 
                return TextStyle(fontFamily: 'CircularStdBold', fontSize: size, fontWeight: FontWeight.w300);
                break;
            case CircularStdFontStyle.Black: 
                return TextStyle(fontFamily: 'CircularStdBlack', fontSize: size, fontWeight: FontWeight.w400);
                break;
            default: 
                return TextStyle(fontFamily: defaultName, fontSize: size, fontStyle: FontStyle.normal);
                break;
        }
    }
}