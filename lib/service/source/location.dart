import "package:geolocator/geolocator.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:permission_handler/permission_handler.dart";

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
    final splited =
        coordinate.split(",").map((s) => double.parse(s.trim())).toList();
    return Location(splited[0], splited[1]);
  }

  factory Location.parseFromPosition(Position position) {
    return Location(position.latitude, position.longitude);
  }

  factory Location.parseFromLatLng(LatLng position) {
    return Location(position.latitude, position.longitude);
  }
}

class LocationService {
  static Position position; // coordinate
  static IndonesiaPlace indonesiaPlace; // place detail

  static Future<bool> askForPermission() async {
    await PermissionHandler().requestPermissions([PermissionGroup.location]);
    return await LocationService.isLocationRequestPermitted();
  }

  static Future<bool> isLocationRequestPermitted() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);

    return permission == PermissionStatus.granted ||
        permission == PermissionStatus.restricted;
  }

  static Future<Position> getCurrentLocation() async {
    position =
        await Geolocator().getCurrentPosition().timeout(Duration(seconds: 10));
    return position;
  }

  static Future<IndonesiaPlace> getPlaceDetail(Location position) async {
    // TODO: use server side geocode
    final places = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    if (places.isNotEmpty) {
      indonesiaPlace = IndonesiaPlace(
          places[0].administrativeArea,
          places[0].locality,
          places[0].subLocality,
          "${places[0].thoroughfare} ${places[0].subThoroughfare}",
          position);
      return indonesiaPlace;
    } else {
      return null;
    }
  }

  /// Use these function to minimize google api call
  static Future<Position> getLastKnownLocation({bool isRefresh = false}) async {
    if (position == null && isRefresh) {
      position = await getCurrentLocation();
    }
    return position;
  }

  static Future<IndonesiaPlace> getLastKnownPlaceDetail(
      {bool isRefresh = false}) async {
    if (indonesiaPlace == null && isRefresh) {
      final position = await getLastKnownLocation();
      indonesiaPlace =
          await getPlaceDetail(Location.parseFromPosition(position));
    }
    return indonesiaPlace;
  }
}
