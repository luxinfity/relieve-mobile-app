import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:relieve_app/service/source/location.dart';
import 'package:relieve_app/utils/common_utils.dart';

enum ImageFormat { JPEG, PNG, GIF }

class StaticMap {
  static const String baseUrl =
      "https://maps.googleapis.com/maps/api/staticmap?";

  /// Location Parameter
  final Location center;
  final int zoom;

  /// Location Parameter
  final int width;
  final int height;

  /// Map Parameter
  final ImageFormat imageFormat;
  final MapType mapType;

  StaticMap(this.center, this.width, this.height,
      {this.zoom = 15,
      this.imageFormat = ImageFormat.JPEG,
      this.mapType = MapType.normal});

  String generateGoogleStaticUrl(BuildContext context,
      {Map<String, String> queries}) {
    String queryString = """
      key=${getGoogleApiKey(context)}&
      center=${center.toString()}&
      zoom=$zoom&
      size=${width}x$height&
      format=${imageFormat.toString().split('.')[1]}&
      maptype=${mapType.toString().split('.')[1]}
    """
        .replaceAll(RegExp(r'[ \n]'), ""); // replace space and newline

    queries?.forEach((key, value) {
      queryString += "&$key=$value";
    });

    queryString = Uri.encodeFull(queryString);
    return baseUrl + queryString;
  }

  Widget toMapWidget(BuildContext context, {Map<String, String> queries}) {
    String imageUrl = generateGoogleStaticUrl(context, queries: queries);
    return CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.fitWidth);
  }
}
