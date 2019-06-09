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

class Coordinate extends LatLng {
  const Coordinate(double latitude, double longitude)
      : super(latitude, longitude);

  @override
  String toString() {
    return '$latitude,$longitude';
  }

  factory Coordinate.parseString(String coordinate) {
    final splitted =
        coordinate.split(',').map((s) => double.parse(s.trim())).toList();
    return Coordinate(splitted[0], splitted[1]);
  }

  factory Coordinate.parseFromPosition(Position position) {
    return Coordinate(position.latitude, position.longitude);
  }
}
