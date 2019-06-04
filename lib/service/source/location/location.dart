import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:relieve_app/res/res.dart';
import 'package:relieve_app/service/model/location.dart';
import 'package:relieve_app/service/service.dart';
import 'package:relieve_app/service/source/api/bakau/bakau_provider.dart';
import 'package:relieve_app/widget/common/bottom_modal.dart';
import 'package:relieve_app/widget/inherited/app_config.dart';

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
  static Future<IndonesiaPlace> getPlaceDetail(
      BuildContext context, Location position) async {
    final locationResponse = await Api.get()
        .setProvider(BakauProvider())
        .getAddressDetailOfPosition(position);

    if (locationResponse?.status == REQUEST_SUCCESS &&
        locationResponse.content != null) {
      indonesiaPlace = IndonesiaPlace(
          locationResponse.content.area1,
          locationResponse.content.area2,
          locationResponse.content.area3,
          locationResponse.content.street,
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
    BuildContext context, {
    bool isRefresh = false,
  }) async {
    if (indonesiaPlace == null || isRefresh) {
      final position = await getLastKnownLocation();
      if (position != null) {
        indonesiaPlace =
            await getPlaceDetail(context, Location.parseFromPosition(position));
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
            'Izinkan Relieve mengetahui lokasi kamu',
            style: CircularStdFont.black.getStyle(size: Dimen.x18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimen.x16),
          child: RaisedButton(
            child: Text('Izinkan'),
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
