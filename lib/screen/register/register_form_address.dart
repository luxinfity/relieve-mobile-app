import 'dart:async';
import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import "package:relieve_app/res/res.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:relieve_app/utils/common_utils.dart";
import "package:relieve_app/widget/item/standard_button.dart";
import "package:relieve_app/widget/item/title.dart";
import "package:permission_handler/permission_handler.dart";
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class MapAddress {
  final String coordinate;
  final String address;
  final String name;

  MapAddress(this.coordinate, this.address, this.name);
}

typedef MapAddressFormCallback = void Function(MapAddress profile);

class RegisterFormAddress extends StatefulWidget {
  final VoidContextCallback onBackClick;
  final MapAddressFormCallback onNextClick;
  final MapAddress initialData;

  const RegisterFormAddress({
    Key key,
    this.onBackClick,
    this.onNextClick,
    this.initialData,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RegisterFormAddressState();
  }
}

class RegisterFormAddressState extends State<RegisterFormAddress> {
  var isAddressValid = true;
  var isNameValid = true;

  final coordinateController = TextEditingController();
  final addressController = TextEditingController();
  final nameController = TextEditingController();

  final FocusNode _addressFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      coordinateController.text = widget.initialData.coordinate;
      addressController.text = widget.initialData.address;
      nameController.text = widget.initialData.name;
    }
  }

  // TODO: enable check permission
//  Future<bool> checkPermissionDenied() async {
//    PermissionStatus permission = await PermissionHandler()
//        .checkPermissionStatus(PermissionGroup.location);
//
//    bool hasNoPermission = permission == PermissionStatus.denied ||
//        permission == PermissionStatus.unknown;
//
//    if (Theme.of(context).platform == TargetPlatform.iOS && hasNoPermission) {
//      isPermissionDenied = true;
//    } else {
//      isPermissionDenied = false;
//    }
//
//    return isPermissionDenied;
//  }

//      default:
//        return LocationPermissionScreen(
//          onPermissionGranted: () {
//            setState(() {
//              progressCount = 2;
//            });
//          },
//        );

  void onSaveClick() {
    setState(() {
      isAddressValid = addressController.text.length >= 2;
      isNameValid = nameController.text.length >= 2;

      if (isAddressValid && isNameValid) {
        widget.onNextClick(MapAddress(
          coordinateController.text,
          addressController.text.toLowerCase(),
          nameController.text.toLowerCase(),
        ));
      }
    });
  }

  bool isFormFilled() {
    return ![coordinateController, addressController, nameController]
        .any((controller) => controller.text.isEmpty);
  }

  String getErrorText(TextEditingController controller) {
    if (!isAddressValid && controller == addressController) {
      return "Alamat minimal 2 huruf";
    } else if (!isNameValid && controller == nameController) {
      return "Nama tempat minimal 2 huruf";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets safePadding = MediaQuery.of(context).padding;
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            padding: safePadding.copyWith(top: 0),
            children: <Widget>[
              ThemedTitle(
                title: "Alamat Tinggal",
                subtitle:
                    "Informasi aplikasi akan sesuai dengan alamat kamu tinggal",
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: Dimen.x8,
                  bottom: Dimen.x6,
                  left: Dimen.x16,
                  right: Dimen.x16,
                ),
                child: TextFormField(
                  controller: coordinateController,
                  decoration: InputDecoration(
                    labelText: "Temukan dengan peta",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimen.x6),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: Dimen.x8,
                  bottom: Dimen.x6,
                  left: Dimen.x16,
                  right: Dimen.x16,
                ),
                child: TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                      labelText: "Alamat Lengkap",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimen.x6),
                      ),
                      errorText: getErrorText(addressController)),
                  focusNode: _addressFocus,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (term) {
                    _addressFocus.unfocus();
                    FocusScope.of(context).requestFocus(_nameFocus);
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: Dimen.x8,
                  bottom: Dimen.x6,
                  left: Dimen.x16,
                  right: Dimen.x16,
                ),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Nama Rumah",
                    helperText: "Contoh : Rumah, Kantor, Rumah Bandung",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimen.x6),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: Dimen.x32, right: Dimen.x32),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: "Dengan mendaftar, kamu menyetujui ",
                style: CircularStdFont.book
                    .getStyle(size: Dimen.x12, color: AppColor.colorTextBlack),
                children: <TextSpan>[
                  TextSpan(
                    text: "ketentuan layanan dan kebijakan perivasi",
                    style: CircularStdFont.book.getStyle(
                        size: Dimen.x12, color: AppColor.colorPrimary),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launch(
                            "https://github.com/RelieveID/terms-and-conditions/");
                      },
                  ),
                  TextSpan(text: " dalam penggunaan Relieve.ID")
                ]),
          ),
        ),
        StandardButton(
          text: "Simpan",
          isEnabled: isFormFilled(),
          buttonClick: onSaveClick,
          backgroundColor: AppColor.colorPrimary,
        ),
        Container(
          height: Dimen.x16 + safePadding.bottom,
        )
      ],
    );
  }
}
