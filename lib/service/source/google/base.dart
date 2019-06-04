import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignInScope = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

String getGoogleApiKey(BuildContext context) {
  if (Theme.of(context).platform == TargetPlatform.iOS) {
    return 'IOS_API_KEY';
  } else {
    return 'ANDROID_API_KEY';
  }
}
