import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RemoteImage {
  final String imageName;

  const RemoteImage(this.imageName);

  CachedNetworkImage toImage({
    double width,
    double height,
    Color color,
    BoxFit fit,
    Duration fadeInDuration = const Duration(milliseconds: 700),
  }) {
    return CachedNetworkImage(
      imageUrl: base_url + this.imageName,
      width: width,
      height: height,
      color: color,
      fit: fit,
      fadeInDuration: fadeInDuration,
    );
  }

  static const base_url =
      'https://raw.githubusercontent.com/RelieveID/mobile-apps-assets/master/images/';

  static RemoteImage get boardingHome => RemoteImage('sketch-01.png');
  static RemoteImage get boardingLogin => RemoteImage('sketch-02.png');
  static RemoteImage get walkthrough1 => RemoteImage('sketch-03.png');
  static RemoteImage get walkthrough2 => RemoteImage('sketch-04.png');
  static RemoteImage get walkthrough3 => RemoteImage('sketch-05.png');
  static RemoteImage get walkthrough4 => RemoteImage('sketch-06.png');
  static RemoteImage get bg_jawa_barat => RemoteImage('home-bg/jawa-barat.png');
  static RemoteImage get bg_map => RemoteImage('bg_map.png');
  static RemoteImage get bg_map2 => RemoteImage('bg_map2.png');
  static RemoteImage get ic_app_circle => RemoteImage('ic_app_circle.png');
}

class LocalImage {
  final String imageName;

  const LocalImage(this.imageName);

  SvgPicture toSvg({double width, double height, Color color}) {
    return SvgPicture.asset('images/$imageName.svg',
        width: width, height: height, color: color);
  }

  static LocalImage get ic_google => LocalImage('ic_google');
  static LocalImage get ic_back_arrow => LocalImage('ic_back_arrow');
  static LocalImage get ic_cross => LocalImage('ic_cross');
  static LocalImage get ic_drop_down => LocalImage('ic_drop_down');

  // dasboard
  static LocalImage get ic_call => LocalImage('ic_call');
  static LocalImage get ic_chat => LocalImage('ic_chat');
  static LocalImage get ic_discover => LocalImage('ic_discover');
  static LocalImage get ic_home => LocalImage('ic_home');
  static LocalImage get ic_profile => LocalImage('ic_profile');

  // items
  static LocalImage get ic_live => LocalImage('ic_live');
  static LocalImage get ic_add_user => LocalImage('ic_add_user');
  static LocalImage get dashed_circle => LocalImage('dashed_circle');

  // maps
  static LocalImage get ic_map => LocalImage('ic_map');
  static LocalImage get ic_map_pin => LocalImage('ic_map_pin');

  // profile
  static LocalImage get ic_location => LocalImage('ic_location');
  static LocalImage get ic_exit => LocalImage('ic_exit');
  static LocalImage get ic_faq => LocalImage('ic_faq');
  static LocalImage get ic_info_contributor =>
      LocalImage('ic_info_contributor');
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
  static LocalImage get ic_check => LocalImage('ic_check');

  // modal
  static LocalImage get ic_guard => LocalImage('ic_guard');
  static LocalImage get ic_warning => LocalImage('ic_warning');

  // user ping
  static LocalImage get ic_address_sign => LocalImage('ic_address_sign');
  static LocalImage get ic_clock => LocalImage('ic_clock');
  static LocalImage get ic_ping => LocalImage('ic_ping');

  // Weather
  static LocalImage get ic_temperature => LocalImage('ic_temperature');
  static LocalImage get ic_wind => LocalImage('ic_wind');
  static LocalImage get ic_sun => LocalImage('ic_sun');
  static LocalImage get ic_rain => LocalImage('ic_rain');

  // setting
  static LocalImage get ic_gallery => LocalImage('ic_gallery');
  static LocalImage get ic_camera => LocalImage('ic_camera');
  static LocalImage get ic_search => LocalImage('ic_search');
}
