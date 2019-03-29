import "package:google_maps_flutter/google_maps_flutter.dart";

// dummy
final lat = -6.892534;
final long = 107.613463;

class Location extends LatLng {
  const Location(double latitude, double longitude)
      : super(latitude, longitude);

  @override
  String toString() {
    return "$latitude, $longitude";
  }

  factory Location.parseString(String coordinate) {
    final splited = coordinate.split(", ").map((s) => double.parse(s)).toList();
    return Location(splited[0], splited[1]);
  }
}

class LocationService {
  static Location gerCurrentLocation() {
    return Location(lat, long);
  }
}
