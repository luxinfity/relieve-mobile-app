import 'package:geolocator/geolocator.dart';
import "package:google_maps_flutter/google_maps_flutter.dart";
import 'package:permission_handler/permission_handler.dart';

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
    return "$latitude,$longitude";
  }

  factory Location.parseString(String coordinate) {
    final splited = coordinate.split(",").map((s) => double.parse(s.trim())).toList();
    return Location(splited[0], splited[1]);
  }

  factory Location.parseFromPosition(Position position) {
    return Location(position.latitude, position.longitude);
  }
}

class LocationService {
  static Future<Position> gerCurrentLocation() async {
    return await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  static Future<IndonesiaPlace> getPlaceDetail(Location position) async {
    final places = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    if (places.isNotEmpty) {
      return IndonesiaPlace(
          places[0].administrativeArea,
          places[0].locality,
          places[0].subLocality,
          "${places[0].thoroughfare} ${places[0].subThoroughfare}",
          position);
    } else {
      return null;
    }
  }
}

Future<bool> isLocationRequestPermitted() async {
  PermissionStatus permission =
      await PermissionHandler().checkPermissionStatus(PermissionGroup.location);

  return permission == PermissionStatus.granted ||
      permission == PermissionStatus.restricted;
}
