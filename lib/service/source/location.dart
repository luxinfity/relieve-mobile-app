import 'package:flutter/material.dart';
import "package:geolocator/geolocator.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:permission_handler/permission_handler.dart";
import 'package:relieve_app/res/res.dart';
import 'package:relieve_app/widget/bottom_modal.dart';

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
  static bool _isBottomSheetShowed = false;
  static List<VoidCallback> _onPermittedCallBackList = new List();

  static Future<bool> _askForPermission() async {
    await PermissionHandler().requestPermissions([PermissionGroup.location]);
    final hasPermitted = await LocationService.isLocationRequestPermitted();

    if (!hasPermitted) {
      // try to open app setting
      await PermissionHandler().openAppSettings();
      return await LocationService.isLocationRequestPermitted();
    } else {
      return true;
    }
  }

  static Future<bool> isLocationRequestPermitted() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);

    return permission == PermissionStatus.granted ||
        permission == PermissionStatus.restricted;
  }

  /// nullable return value
  static Future<Position> getCurrentLocation() async {
    if (await isLocationRequestPermitted()) {
      position = await Geolocator()
          .getCurrentPosition()
          .timeout(Duration(seconds: 10));
      return position;
    } else {
      return position;
    }
  }

  /// nullable return value
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
  /// only one request at a time
  /// nullable return value
  static Future<Position> getLastKnownLocation({bool isRefresh = false}) async {
    if (position == null || isRefresh) {
      position = await getCurrentLocation();
    }
    return position;
  }

  /// nullable return value
  static Future<IndonesiaPlace> getLastKnownPlaceDetail(
      {bool isRefresh = false}) async {
    if (indonesiaPlace == null || isRefresh) {
      final position = await getLastKnownLocation();
      if (position != null) {
        indonesiaPlace =
            await getPlaceDetail(Location.parseFromPosition(position));
      }
    }
    return indonesiaPlace;
  }

  static void showAskPermissionModal(
      BuildContext context, VoidCallback onPermitted) {
    _onPermittedCallBackList.add(onPermitted);
    if (_isBottomSheetShowed) {
      return;
    }
    createRelieveBottomModal(
      context,
      <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              top: Dimen.x12,
              bottom: Dimen.x32,
              right: Dimen.x16,
              left: Dimen.x16),
          child: Text(
            "Izinkan Relieve mengetahui lokasi kamu",
            style: CircularStdFont.black.getStyle(size: Dimen.x18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimen.x16),
          child: RaisedButton(
            child: Text("Izinkan"),
            color: AppColor.colorPrimary,
            textColor: Colors.white,
            elevation: 1,
            highlightElevation: 1,
            padding: EdgeInsets.symmetric(
              vertical: Dimen.x16,
              horizontal: Dimen.x28,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimen.x4),
            ),
            onPressed: () async {
              final isPermitted = await _askForPermission();
              if (isPermitted) {
                Navigator.of(context).pop();
                _onPermittedCallBackList.forEach((func) {
                  func();
                });
                _onPermittedCallBackList.clear();
              }
            },
          ),
        )
      ],
      onWillPop: () {
        _isBottomSheetShowed = false;
        _onPermittedCallBackList.clear();
        return new Future.value(true);
      },
    );
    _isBottomSheetShowed = true;
  }
}
