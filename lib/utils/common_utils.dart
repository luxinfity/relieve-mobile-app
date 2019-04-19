import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';


typedef VoidContextCallback = void Function(BuildContext context);
typedef StringCallback = String Function();

void defaultBackPressed(BuildContext context) {
  Navigator.pop(context);
}

String getGoogleApiKey(BuildContext context) {
  if (Theme.of(context).platform == TargetPlatform.iOS) {
    return 'IOS_API_KEY';
  } else {
    return 'ANDROID_API_KEY';
  }
}

final GoogleSignIn googleSignInScope = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

final CameraPosition jakartaCoordinate = CameraPosition(
  target: LatLng(-6.21462, 106.84513),
  zoom: 14,
);

Timer _debounceTimer;

void debounce(VoidCallback callback,
    {Duration duration = const Duration(seconds: 3)}) {
  if (_debounceTimer != null) {
    _debounceTimer.cancel();
  }

  _debounceTimer = Timer(duration, callback);
}
