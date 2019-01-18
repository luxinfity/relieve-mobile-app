import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class RemoteImage {
  final String imageName;

  const RemoteImage(this.imageName);

  Image toImage({double width, double height, Color color, BoxFit fit}) {
    return Image.network(
      base_url + this.imageName,
      width: width,
      height: height,
      color: color,
      fit: fit,
    );
  }

  static const base_url =
      'https://raw.githubusercontent.com/RelieveID/mobile-apps-assets/master/images/';

  static RemoteImage get boardingHome => RemoteImage('sketch-01.png');
  static RemoteImage get boardingLogin => RemoteImage('sketchh-02.png');
  static RemoteImage get bg_bali => RemoteImage('bg_bali.png');
  static RemoteImage get bg_map => RemoteImage('bg_map.png');
  static RemoteImage get bg_map2 => RemoteImage('bg_map2.png');
}

class LocalImage {
  final String imageName;

  const LocalImage(this.imageName);

  SvgPicture toSvg({double width, double height, Color color}) {
    return SvgPicture.asset('images/' + imageName + '.svg',
        width: width, height: height, color: color);
  }

  static LocalImage get ic_google => LocalImage('ic_google');
  static LocalImage get ic_back_arrow => LocalImage('ic_back_arrow');
  static LocalImage get ic_cross => LocalImage('ic_cross');
  static LocalImage get ic_drop_down => LocalImage('ic_drop_down');

  // dasboard
  static LocalImage get ic_call => const LocalImage('ic_call');
  static LocalImage get ic_chat => LocalImage('ic_chat');
  static LocalImage get ic_discover => LocalImage('ic_discover');
  static LocalImage get ic_home => LocalImage('ic_home');
  static LocalImage get ic_profile => LocalImage('ic_profile');

  // items
  static LocalImage get ic_live => LocalImage('ic_live');
  static LocalImage get ic_add_user => LocalImage('ic_add_user');
  static LocalImage get dashed_circle => LocalImage('dashed_circle');

  // profile
  static LocalImage get ic_location => LocalImage('ic_location');
  static LocalImage get ic_exit => LocalImage('ic_exit');
  static LocalImage get ic_faq => LocalImage('ic_faq');
  static LocalImage get ic_info_contributor => LocalImage('ic_info_contributor');
  static LocalImage get ic_notif => LocalImage('ic_notif');
  static LocalImage get ic_privacy => LocalImage('ic_privacy');
  static LocalImage get ic_syarat => LocalImage('ic_syarat');
  static LocalImage get ic_user => LocalImage('ic_user');

  // organization
  static LocalImage get ic_add_other => LocalImage('ic_add_other');
  static LocalImage get ic_ambulance => LocalImage('ic_ambulance');
  static LocalImage get ic_bmkg => LocalImage('ic_bmkg');
  static LocalImage get ic_fire_fighter => LocalImage('ic_fire_fighter');
  static LocalImage get ic_medic => LocalImage('ic_medic');
  static LocalImage get ic_others => LocalImage('ic_others');
  static LocalImage get ic_pln => LocalImage('ic_pln');
  static LocalImage get ic_police => LocalImage('ic_police');
  static LocalImage get ic_red_cross => LocalImage('ic_red_cross');
  static LocalImage get ic_sar => LocalImage('ic_sar');
}
