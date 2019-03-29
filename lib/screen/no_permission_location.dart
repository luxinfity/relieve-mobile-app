import "package:flutter/material.dart";
import "package:permission_handler/permission_handler.dart";
import "package:relieve_app/res/res.dart";

class LocationPermissionScreen extends StatefulWidget {
  final VoidCallback onPermissionGranted;

  const LocationPermissionScreen({Key key, this.onPermissionGranted})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => LocationPermissionScreenState();
}

class LocationPermissionScreenState extends State<LocationPermissionScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<Null> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      PermissionStatus permission = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.location);

      bool hasPermission = permission == PermissionStatus.granted ||
          permission == PermissionStatus.restricted;

      if (hasPermission) widget.onPermissionGranted();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(Dimen.x24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Izinkan Relieve Id mengetahui lokasi",
            style: CircularStdFont.black.getStyle(size: Dimen.x21),
            textAlign: TextAlign.center,
          ),
          Container(height: Dimen.x18),
          Text(
            "Informasi lokasi dibutuhkan untuk memberikan kabar terkini sesuai lokasi mu",
            style: CircularStdFont.book.getStyle(
              size: Dimen.x14,
              color: AppColor.colorTextGrey,
            ),
            textAlign: TextAlign.center,
          ),
          Container(height: Dimen.x36),
          RaisedButton(
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
            onPressed: () {
              PermissionHandler().openAppSettings();
            },
          )
        ],
      ),
    );
  }
}
