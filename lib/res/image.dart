import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';

class RemoteImage {
  static const base_url =
      'https://raw.githubusercontent.com/RelieveID/mobile-apps-assets/master/images/';
  static const boardingHome = base_url + 'sketch-01.png';
  static const boardingLogin = base_url + 'sketchh-02.png';
}

class LocalImage {
  final String imageName;

  LocalImage(this.imageName);

  SvgPicture toSvg({int width, int height, Color color}) {
    return SvgPicture.asset('images/' + imageName + '.svg',
        width: width?.toDouble(), height: height?.toDouble(), color: color);
  }

  static get ic_call => LocalImage('ic_call');
  static get ic_chat => LocalImage('ic_chat');
  static get ic_discover => LocalImage('ic_discover');
  static get ic_home => LocalImage('ic_home');
  static get ic_profile => LocalImage('ic_profile');
}
