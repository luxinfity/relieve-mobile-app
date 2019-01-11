import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class RemoteImage {
  final String imageName;

  const RemoteImage(this.imageName);

  Image toImage({int width, int height, Color color, BoxFit fit}) {
    return Image.network(
      base_url + this.imageName,
      width: width?.toDouble(),
      height: height?.toDouble(),
      color: color,
      fit: fit,
    );
  }

  static const base_url =
      'https://raw.githubusercontent.com/RelieveID/mobile-apps-assets/master/images/';

  static RemoteImage get boardingHome => RemoteImage('sketch-01.png');
  static RemoteImage get boardingLogin => RemoteImage('sketchh-02.png');
  static RemoteImage get bg_bali => RemoteImage('bg_bali.png');
  static RemoteImage get img_dinda => RemoteImage('item_dinda.png');
}

class LocalImage {
  final String imageName;

  LocalImage(this.imageName);

  SvgPicture toSvg({int width, int height, Color color}) {
    return SvgPicture.asset('images/' + imageName + '.svg',
        width: width?.toDouble(), height: height?.toDouble(), color: color);
  }

  static LocalImage get ic_google => LocalImage('ic_google');
  static LocalImage get ic_back_arrow => LocalImage('ic_back_arrow');

  // dasboard
  static LocalImage get ic_call => LocalImage('ic_call');
  static LocalImage get ic_chat => LocalImage('ic_chat');
  static LocalImage get ic_discover => LocalImage('ic_discover');
  static LocalImage get ic_home => LocalImage('ic_home');
  static LocalImage get ic_profile => LocalImage('ic_profile');

  // items
  static LocalImage get ic_live => LocalImage('ic_live');
  static LocalImage get ic_add_user => LocalImage('ic_add_user');
}
