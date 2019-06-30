import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IndonesiaPlace {
  final String province;
  final String city;
  final String district;
  final String street;
  final Coordinate coordinate;

  IndonesiaPlace(
      this.province, this.city, this.district, this.street, this.coordinate);
}

class Coordinate {
  final double latitude;
  final double longitude;

  const Coordinate(this.latitude, this.longitude);

  @override
  String toString() {
    return '$latitude,$longitude';
  }

  LatLng toLatLng() => LatLng(latitude, longitude);

  Position toPosition() => Position(latitude: latitude, longitude: longitude);

  factory Coordinate.parseString(String coordinate) {
    if (coordinate == null) return null;

    final splitted =
        coordinate.split(',').map((s) => double.parse(s.trim())).toList();
    return Coordinate(splitted[0], splitted[1]);
  }

  factory Coordinate.parseFromPosition(Position position) {
    return Coordinate(position.latitude, position.longitude);
  }

  factory Coordinate.parseFromLatLng(LatLng latLng) {
    return Coordinate(latLng.latitude, latLng.longitude);
  }
}
