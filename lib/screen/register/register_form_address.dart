import 'dart:async';
import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import "package:relieve_app/res/res.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:relieve_app/utils/common_utils.dart";
import "package:relieve_app/widget/item/standard_button.dart";
import "package:relieve_app/widget/item/title.dart";
import "package:permission_handler/permission_handler.dart";
import 'package:geolocator/geolocator.dart';

class RegisterFormAddress extends StatefulWidget {
  final VoidContextCallback onBackClick;
  final VoidCallback onNextClick;

  const RegisterFormAddress({Key key, this.onBackClick, this.onNextClick})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RegisterFormAddressState();
  }
}

class RegisterFormAddressState extends State<RegisterFormAddress> {
  CameraPosition currentPositionCamera;
  CameraPosition mapCenter;
  Completer<GoogleMapController> _mapController = Completer();

  final debounceDuration = 3; // second

  String addressTitle = "DKI Jakarta";
  String addressDetail = "Kantor Relieve ID";

  void loadLocation() async {
    // checkPermission
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);

    bool hasPermission = permission == PermissionStatus.granted ||
        permission == PermissionStatus.restricted;

    if (!hasPermission &&
        Theme.of(context).platform == TargetPlatform.android) {
      await PermissionHandler().requestPermissions([PermissionGroup.location]);
    }

    final position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    currentPositionCamera = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 14,
    );
  }

  void moveToMyLocation() async {
    if (currentPositionCamera == null) {
      final position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      currentPositionCamera = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14,
      );
    }

    final controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(currentPositionCamera),
    );
  }

  void cameraMoved(CameraPosition movedPosition) async {
    mapCenter = movedPosition;
  }

  Timer searchDebounce;

  void cameraIdle() {
    if (searchDebounce != null) {
      searchDebounce.cancel();
    }

    searchDebounce = Timer(Duration(seconds: debounceDuration), () async {
      final position = mapCenter.target;

      List<Placemark> locationDetail = await Geolocator()
          .placemarkFromCoordinates(position.latitude, position.longitude);

      setState(() {
        addressTitle = "${locationDetail[0].thoroughfare} ${locationDetail[0]
            .subThoroughfare}";
        addressDetail = "${locationDetail[0].thoroughfare} " +
            "${locationDetail[0].subThoroughfare} " +
            "${locationDetail[0].subLocality} " +
            "${locationDetail[0].locality} " +
            "${locationDetail[0].subAdministrativeArea} " +
            "${locationDetail[0].administrativeArea}";
      });
    });
  }

  void cameraStartMoving() {
    setState(() {
      addressTitle = "";
      addressDetail = "";
    });
  }

  @override
  void initState() {
    super.initState();
    loadLocation();
  }

  List<Widget> getAddressColumn() {
    if (addressTitle.isEmpty || addressDetail.isEmpty) {
      return <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          width: 50,
          child: SpinKitThreeBounce(
            color: AppColor.colorTextBlack,
            size: Dimen.x14,
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          width: 50,
          child: SpinKitThreeBounce(
            color: AppColor.colorTextBlack,
            size: Dimen.x14,
          ),
        ),
      ];
    } else {
      return <Widget>[
        Text(
          addressTitle,
          style: CircularStdFont.medium.getStyle(size: Dimen.x16),
        ),
        Text(
          addressDetail,
          style: CircularStdFont.book.getStyle(size: Dimen.x14),
        ),
      ];
    }
  }

  Widget createAddressBar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(left: Dimen.x16, right: Dimen.x16),
          height: Dimen.x42,
          width: Dimen.x42,
          alignment: Alignment.center,
          child:
              LocalImage.ic_map.toSvg(color: Colors.white, height: Dimen.x21),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.colorPrimary,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: getAddressColumn(),
          ),
        ),
        Container(width: Dimen.x16)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets safePadding = MediaQuery.of(context).padding;
    return Column(
      children: <Widget>[
        Expanded(
          child: Stack(
            children: <Widget>[
              GoogleMap(
                initialCameraPosition: currentPositionCamera == null
                    ? jakartaCoordinate
                    : currentPositionCamera,
                myLocationEnabled: true,
                onMapCreated: (controller) {
                  _mapController.complete(controller);
                  moveToMyLocation();
                },
                onCameraMove: cameraMoved,
                onCameraIdle: cameraIdle,
                onCameraMoveStarted: cameraStartMoving,
              ),
              Align(
                child: LocalImage.ic_map_pin.toSvg(width: Dimen.x64),
                alignment: Theme.of(context).platform == TargetPlatform.iOS
                    ? Alignment(0, -0.11)
                    : Alignment(0, -0.2),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimen.x8),
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  elevation: Dimen.x4,
                  highlightElevation: Dimen.x4,
                  child: LocalImage.ic_back_arrow.toSvg(height: 26),
                  onPressed: () => widget.onBackClick(context),
                ),
              ),
              Align(
                alignment: Theme.of(context).platform == TargetPlatform.iOS
                    ? Alignment.bottomRight
                    : Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(Dimen.x10),
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    elevation: Theme.of(context).platform == TargetPlatform.iOS
                        ? 0
                        : Dimen.x4,
                    highlightElevation: Dimen.x4,
                    child: Icon(
                      Icons.gps_fixed,
                      color: AppColor.colorPrimary,
                    ),
                    onPressed: () {
                      moveToMyLocation();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(height: Dimen.x16),
        ThemedTitle(
          title: "Temukan alamat kamu",
        ),
        Container(height: Dimen.x10),
        createAddressBar(),
        Container(height: Dimen.x21),
        StandardButton(
          text: "Simpan",
          backgroundColor: AppColor.colorPrimary,
          buttonClick: () {},
        ),
        Container(height: Dimen.x16 + safePadding.bottom)
      ],
    );
  }
}
