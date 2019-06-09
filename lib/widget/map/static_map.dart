import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:relieve_app/datamodel/map_data.dart';
import 'package:relieve_app/service/google/base.dart';

enum ImageFormat { JPEG, PNG, GIF }

class StaticMap extends StatelessWidget {
  final MapData mapData;

  StaticMap(this.mapData);

  @override
  Widget build(BuildContext context) {
    String imageUrl = generateGoogleStaticUrl(context, this.mapData);
    return CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.fitWidth);
  }
}
