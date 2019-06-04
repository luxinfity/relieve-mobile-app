import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:relieve_app/datamodel/location.dart';

enum ImageFormat { JPEG, PNG, GIF }

class MapData {
  /// Location Parameter
  final Location center;
  final int zoom;

  /// Location Parameter
  final int width;
  final int height;

  /// Map Parameter
  final ImageFormat imageFormat;
  final MapType mapType;

  final Map<String, String> queries;

  MapData(
    this.center,
    this.width,
    this.height, {
    this.zoom = 15,
    this.imageFormat = ImageFormat.JPEG,
    this.mapType = MapType.normal,
    this.queries = const {},
  });
}
