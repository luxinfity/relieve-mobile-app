import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

typedef VoidContextCallback = void Function(BuildContext context);
typedef StringCallback = String Function();

void defaultBackPressed(BuildContext context) {
  Navigator.pop(context);
}

final GoogleSignIn googleSignInScope = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

String getApiKey(BuildContext context) {
  if (Theme.of(context).platform == TargetPlatform.iOS) {
    return "IOS_API_KEY";
  } else {
    return "ANDROID_API_KEY";
  }
}