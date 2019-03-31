import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import 'package:permission_handler/permission_handler.dart';
import "package:relieve_app/res/res.dart";
import "package:relieve_app/screen/register/register_form_map.dart";
import 'package:relieve_app/service/service.dart';
import "package:relieve_app/utils/common_utils.dart";
import 'package:relieve_app/widget/bottom_modal.dart';
import "package:relieve_app/widget/item/standard_button.dart";
import "package:relieve_app/widget/item/title.dart";
import "package:url_launcher/url_launcher.dart";
export "package:relieve_app/screen/register/register_form_map.dart";

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

  void tryAllowPermission() async {
    if (!await LocationService.askForPermission()) {
      await PermissionHandler().openAppSettings();
      if (!await LocationService.isLocationRequestPermitted()) return;
    }

    Navigator.of(context).pop();
    moveToMap();
  }

  void moveToMap() async {
    if (!await LocationService.isLocationRequestPermitted()) {
      createRelieveBottomModal(context, <Widget>[
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
            onPressed: () {
              tryAllowPermission();
            },
          ),
        )
      ]);
    } else {
      final result = await Navigator.push(
          context, MaterialPageRoute(builder: (builder) => RegisterFormMap()));
      if (result != null) {
        final mapAddress = (result as MapAddress);
        setState(() {
          coordinateController.text = mapAddress.coordinate;
          addressController.text = mapAddress.address;
        });
      }
    }
  }

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
                  top: Dimen.x32,
                  bottom: Dimen.x6,
                  left: Dimen.x16,
                  right: Dimen.x16,
                ),
                child: InkWell(
                  onTap: moveToMap,
                  child: TextFormField(
                    enabled: false,
                    controller: coordinateController,
                    decoration: InputDecoration(
                      labelText: "Temukan dengan peta",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimen.x6),
                      ),
                      suffixIcon: IconButton(
                        icon: LocalImage.ic_map.toSvg(),
                        onPressed: () {},
                      ),
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
                  maxLines: null,
                  decoration: InputDecoration(
                      labelText: "Alamat Lengkap",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimen.x6),
                      ),
                      errorText: getErrorText(addressController)),
                  focusNode: _addressFocus,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (term) {
                    _nameFocus.unfocus();
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
                  focusNode: _nameFocus,
                  textInputAction: TextInputAction.done,
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
          text: "Daftar",
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
