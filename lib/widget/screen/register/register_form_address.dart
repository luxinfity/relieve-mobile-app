import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:relieve_app/datamodel/address.dart';
import 'package:relieve_app/datamodel/location.dart';
import 'package:relieve_app/res/res.dart';
import 'package:relieve_app/service/service.dart';
import 'package:relieve_app/utils/relieve_callback.dart';
import 'package:relieve_app/widget/common/standard_button.dart';
import 'package:relieve_app/widget/common/title.dart';
import 'package:relieve_app/widget/screen/register/register_form_map.dart';
import 'package:url_launcher/url_launcher.dart';

export 'package:relieve_app/widget/screen/register/register_form_map.dart';

class RegisterFormAddress extends StatefulWidget {
  final VoidCallbackContext onBackClick;
  final VoidCallbackAddress onNextClick;
  final Address initialData;

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
  final streetController = TextEditingController();
  final labelController = TextEditingController();

  final FocusNode _addressFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      coordinateController.text = widget.initialData.coordinate.toString();
      streetController.text = widget.initialData.street;
      labelController.text = widget.initialData.label;
    }
  }

  void moveToMap() async {
    if (!await LocationService.isLocationRequestPermitted()) {
      LocationService.showAskPermissionModal(context, () {
        // if permitted
        moveToMap();
      });
    } else {
      final result = await Navigator.push(
          context, MaterialPageRoute(builder: (builder) => RegisterFormMap()));
      if (result != null) {
        final address = (result as Address);
        setState(() {
          coordinateController.text = address.coordinate.toString();
          streetController.text = address.street;
        });
      }
    }
  }

  void onSaveClick() {
    setState(() {
      isAddressValid = streetController.text.length >= 2;
      isNameValid = labelController.text.length >= 2;

      if (isAddressValid && isNameValid) {
        widget.onNextClick(Address(
          label: labelController.text.toLowerCase(),
          street: streetController.text.toLowerCase(),
          coordinate: Coordinate.parseString(coordinateController.text),
        ));
      }
    });
  }

  bool isFormFilled() {
    return ![coordinateController, streetController, labelController]
        .any((controller) => controller.text.isEmpty);
  }

  String getErrorText(TextEditingController controller) {
    if (!isAddressValid && controller == streetController) {
      return 'Alamat minimal 2 huruf';
    } else if (!isNameValid && controller == labelController) {
      return 'Nama tempat minimal 2 huruf';
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
                title: 'Alamat Tinggal',
                subtitle:
                    'Informasi aplikasi akan sesuai dengan alamat kamu tinggal',
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
                      labelText: 'Temukan dengan peta',
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
                  controller: streetController,
                  maxLines: null,
                  decoration: InputDecoration(
                      labelText: 'Alamat Lengkap',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimen.x6),
                      ),
                      errorText: getErrorText(streetController)),
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
                  controller: labelController,
                  decoration: InputDecoration(
                    labelText: 'Nama Rumah',
                    helperText: 'Contoh : Rumah, Kantor, Rumah Bandung',
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
                text: 'Dengan mendaftar, kamu menyetujui ',
                style: CircularStdFont.book
                    .getStyle(size: Dimen.x12, color: AppColor.colorTextBlack),
                children: <TextSpan>[
                  TextSpan(
                    text: 'ketentuan layanan dan kebijakan perivasi',
                    style: CircularStdFont.book.getStyle(
                        size: Dimen.x12, color: AppColor.colorPrimary),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launch(
                            'https://github.com/RelieveID/terms-and-conditions/');
                      },
                  ),
                  TextSpan(text: ' dalam penggunaan Relieve.ID')
                ]),
          ),
        ),
        StandardButton(
          text: 'Daftar',
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
