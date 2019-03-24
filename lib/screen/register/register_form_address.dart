import 'package:flutter/material.dart';
import 'package:relieve_app/res/res.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:relieve_app/utils/common_utils.dart';
import 'package:relieve_app/widget/item/standard_button.dart';
import 'package:relieve_app/widget/item/title.dart';
import 'package:permission_handler/permission_handler.dart';

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
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  void checkPermission() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);

    bool hasPermission = permission == PermissionStatus.granted ||
        permission == PermissionStatus.restricted;

    if (!hasPermission &&
        Theme.of(context).platform == TargetPlatform.android) {
      await PermissionHandler().requestPermissions([PermissionGroup.location]);
    }
  }

  @override
  void initState() {
    super.initState();
    checkPermission();
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
            children: <Widget>[
              Text(
                'Jl. Mahmud No.320',
                style: CircularStdFont.medium.getStyle(size: Dimen.x16),
              ),
              Text(
                'Jl. Mahmud No.320, Pamoyanan, Cicendo, Kota Bandung, Jawa Barat 40173',
                style: CircularStdFont.book.getStyle(size: Dimen.x14),
              ),
            ],
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
                initialCameraPosition: _kGooglePlex,
                myLocationEnabled: true,
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
                child: LocalImage.ic_map_pin.toSvg(width: Dimen.x64),
                alignment: Alignment(0, -0.11),
              )
            ],
          ),
        ),
        Container(height: Dimen.x16),
        ThemedTitle(
          title: 'Temukan alamat kamu',
        ),
        Container(height: Dimen.x10),
        createAddressBar(),
        Container(height: Dimen.x21),
        StandardButton(
          text: 'Simpan',
          backgroundColor: AppColor.colorPrimary,
          buttonClick: () {},
        ),
        Container(height: Dimen.x16 + safePadding.bottom)
      ],
    );
  }
}
