import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackgroundImage {
  final String imageName;

  BackgroundImage(this.imageName);

  CachedNetworkImage toImage({
    double width,
    double height,
    Color color,
    BoxFit fit,
    Duration fadeInDuration = const Duration(milliseconds: 700),
  }) {
    final imageUri = imageName.replaceAll(' ', '-').toLowerCase();
    return RemoteImage('home-bg/$imageUri.png').toImage(
      width: width,
      height: height,
      color: color,
      fit: fit,
      fadeInDuration: fadeInDuration,
    );
  }
}

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

  static RemoteImage get bgMap => RemoteImage('bg_map.png');

  static RemoteImage get bgMap2 => RemoteImage('bg_map2.png');

  static RemoteImage get icAppCircle => RemoteImage('ic_app_circle.png');

  static RemoteImage get bgDkiJakarta => RemoteImage('home-bg/dki-jakarta.png');
}

class LocalImage {
  final String imageName;

  const LocalImage(this.imageName);

  SvgPicture toSvg({double width, double height, Color color}) {
    return SvgPicture.asset('images/$imageName.svg',
        width: width, height: height, color: color);
  }

  static LocalImage get icGoogle => LocalImage('ic_google');

  static LocalImage get icBackArrow => LocalImage('ic_back_arrow');

  static LocalImage get icCross => LocalImage('ic_cross');

  static LocalImage get icDropDown => LocalImage('ic_drop_down');

  // dasboard
  static LocalImage get icCall => LocalImage('ic_call');

  static LocalImage get icChat => LocalImage('ic_chat');

  static LocalImage get icDiscover => LocalImage('ic_discover');

  static LocalImage get icHome => LocalImage('ic_home');

  // items
  static LocalImage get icLive => LocalImage('ic_live');

  static LocalImage get icAddUser => LocalImage('ic_add_user');

  static LocalImage get dashedCircle => LocalImage('dashed_circle');

  // maps
  static LocalImage get icMap => LocalImage('ic_map');

  static LocalImage get icMapPin => LocalImage('ic_map_pin');

  // profile
  static LocalImage get icExit => LocalImage('ic_exit');

  static LocalImage get icFaq => LocalImage('ic_faq');

  static LocalImage get icInfoContributor => LocalImage('ic_info_contributor');

  static LocalImage get icNotification => LocalImage('ic_notif');

  static LocalImage get icPrivacy => LocalImage('ic_privacy');

  static LocalImage get icTerm => LocalImage('ic_syarat');

  static LocalImage get icUser => LocalImage('ic_user');

  // organization
  static LocalImage get icAddOther => LocalImage('ic_add_other');

  static LocalImage get icAmbulance => LocalImage('ic_ambulance');

  static LocalImage get icBmkg => LocalImage('ic_bmkg');

  static LocalImage get icFireFighter => LocalImage('ic_fire_fighter');

  static LocalImage get icMedic => LocalImage('ic_medic');

  static LocalImage get icOthers => LocalImage('ic_others');

  static LocalImage get icPln => LocalImage('ic_pln');

  static LocalImage get icPolice => LocalImage('ic_police');

  static LocalImage get icRedCross => LocalImage('ic_red_cross');

  static LocalImage get icSar => LocalImage('ic_sar');

  static LocalImage get icCheck => LocalImage('ic_check');

  // modal
  static LocalImage get icGuard => LocalImage('ic_guard');

  static LocalImage get icWarning => LocalImage('ic_warning');

  // user ping
  static LocalImage get icAddressSign => LocalImage('ic_address_sign');

  static LocalImage get icClock => LocalImage('ic_clock');

  static LocalImage get icPing => LocalImage('ic_ping');

  // Weather
  static LocalImage get icTemperature => LocalImage('ic_temperature');

  static LocalImage get icWind => LocalImage('ic_wind');

  static LocalImage get icSun => LocalImage('ic_sun');

  static LocalImage get icRain => LocalImage('ic_rain');

  // setting
  static LocalImage get icGallery => LocalImage('ic_gallery');

  static LocalImage get icCamera => LocalImage('ic_camera');

  static LocalImage get icSearch => LocalImage('ic_search');
}
