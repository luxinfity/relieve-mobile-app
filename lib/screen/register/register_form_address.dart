import 'package:flutter/material.dart';
import 'package:relieve_app/res/res.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:relieve_app/utils/common_utils.dart';

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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GoogleMap(
          initialCameraPosition: _kGooglePlex,
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
      ],
    );
  }
}
