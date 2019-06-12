import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:relieve_app/datamodel/map_data.dart';

abstract class GoogleHelper {
  static final GoogleSignIn googleSignInScope = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  static String _getGoogleApiKey(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return 'IOS_API_KEY';
    } else {
      return 'ANDROID_API_KEY';
    }
  }

  static String google_helper(BuildContext context, MapData mapData) {
    const String baseUrl = 'https://maps.googleapis.com/maps/api/staticmap?';

    String queryString = '''
      key=${_getGoogleApiKey(context)}&
      center=${mapData.center.toString()}&
      zoom=${mapData.zoom}&
      size=${mapData.width}x${mapData.height}&
      format=${mapData.imageFormat.toString().split('.')[1]}&
      maptype=${mapData.mapType.toString().split('.')[1]}
    '''
        .replaceAll(RegExp(r'[ \n]'), ''); // replace space and newline

    mapData.queries?.forEach((key, value) {
      queryString += '&$key=$value';
    });

    queryString = Uri.encodeFull(queryString);
    return baseUrl + queryString;
  }
}
