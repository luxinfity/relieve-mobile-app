import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IndonesiaPlace {
  final String province;
  final String city;
  final String district;
  final String street;
  final Location coordinate;

  IndonesiaPlace(
      this.province, this.city, this.district, this.street, this.coordinate);
}

class Location extends LatLng {
  const Location(double latitude, double longitude)
      : super(latitude, longitude);

  @override
  String toString() {
    return '$latitude,$longitude';
  }

  factory Location.parseString(String coordinate) {
    final splited =
        coordinate.split(',').map((s) => double.parse(s.trim())).toList();
    return Location(splited[0], splited[1]);
  }

  factory Location.parseFromPosition(Position position) {
    return Location(position.latitude, position.longitude);
  }

  factory Location.parseFromLatLng(LatLng position) {
    return Location(position.latitude, position.longitude);
  }
}
