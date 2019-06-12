import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:relieve_app/datamodel/gender.dart';
import 'package:relieve_app/datamodel/profile.dart';
import 'package:relieve_app/res/res.dart';
import 'package:relieve_app/utils/relieve_callback.dart';
import 'package:relieve_app/widget/common/bottom_modal.dart';
import 'package:relieve_app/widget/common/standard_button.dart';
import 'package:relieve_app/widget/common/title.dart';
import 'package:validators/validators.dart';

class FormProfile extends StatefulWidget {
  final VoidCallbackProfile onNextClick;
  final Profile initialData;

  const FormProfile({
    Key key,
    this.onNextClick,
    this.initialData,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FormProfileState();
  }
}

class _FormProfileState extends State<FormProfile> {
  bool passwordVisible = false;

  var isFullNameValid = true;
  var isPhoneValid = true;

  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  final genderController = TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      fullNameController.text = widget.initialData.fullName;
      phoneController.text = widget.initialData.phone;
      dobController.text = widget.initialData.birthDate;
      genderController.text = (widget.initialData.gender ?? "").toString();
    }
  }

  void onSaveClick() {
    setState(() {
      isFullNameValid = fullNameController.text.length >= 2;
      isPhoneValid = isNumeric(phoneController.text) &&
          phoneController.text.replaceFirst('0', '').length >= 7;

      if (isFullNameValid && isPhoneValid) {
        widget.onNextClick(widget.initialData.copyWith(
          fullName: fullNameController.text.toLowerCase(),
          phone: phoneController.text.replaceFirst('0', ''),
          birthDate: dobController.text,
          gender: Gender.parseString(genderController.text),
        ));
      }
    });
  }

  bool isFormFilled() {
    return ![
      fullNameController,
      phoneController,
      dobController,
      genderController
    ].any((controller) => controller.text.isEmpty);
  }

  String getErrorText(TextEditingController controller) {
    if (!isFullNameValid && controller == fullNameController) {
      return 'Nama lengkap minimal 2 huruf';
    } else if (!isPhoneValid && controller == phoneController) {
      return 'Panjang nomor handphone tidak valid';
    } else {
      return null;
    }
  }

  void onDoBClick() {
    DatePicker.showDatePicker(
      context,
      locale: DateTimePickerLocale.en_us,
      pickerTheme: DateTimePickerTheme(
        showTitle: true,
        cancel: Text(
          'Batal',
          style: CircularStdFont.book.getStyle(
            size: Dimen.x12,
            color: AppColor.colorDanger,
          ),
        ),
        confirm: Text(
          'Pilih',
          style: CircularStdFont.book.getStyle(
            size: Dimen.x12,
            color: AppColor.colorPrimary,
          ),
        ),
      ),
      onConfirm: (dateTime, selectedIndex) {
        final monthStr = dateTime.month.toString().padLeft(2, '0');
        final dateStr = dateTime.day.toString().padLeft(2, '0');
        dobController.text = '${dateTime.year.toString()}-$monthStr-$dateStr';
        setState(() {});
      },
    );
  }

  void onGenderClick() {
    RelieveBottomModal.create(context, <Widget>[
      ThemedTitle(
        title: 'Pilih jenis kelamin',
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: Dimen.x16),
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimen.x4),
              side: BorderSide(color: AppColor.colorPrimary)),
          padding: EdgeInsets.symmetric(vertical: Dimen.x16),
          child: Text(
            Gender.female.toString(),
            style: CircularStdFont.medium
                .getStyle(size: Dimen.x14, color: AppColor.colorPrimary),
          ),
          onPressed: () {
            genderController.text = Gender.female.toString();
            Navigator.pop(context);
            setState(() {});
          },
        ),
      ),
      Container(height: Dimen.x16),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: Dimen.x16),
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimen.x4),
              side: BorderSide(color: AppColor.colorPrimary)),
          padding: EdgeInsets.symmetric(vertical: Dimen.x16),
          child: Text(
            Gender.male.toString(),
            style: CircularStdFont.medium
                .getStyle(size: Dimen.x14, color: AppColor.colorPrimary),
          ),
          onPressed: () {
            genderController.text = Gender.male.toString();
            Navigator.pop(context);
            setState(() {});
          },
        ),
      ),
    ]);
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
                title: 'Data Diri',
                subtitle: 'Beritahu kami mengenai diri kamu',
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: Dimen.x32,
                  bottom: Dimen.x6,
                  left: Dimen.x16,
                  right: Dimen.x16,
                ),
                child: TextFormField(
                  controller: fullNameController,
                  decoration: InputDecoration(
                      labelText: 'Nama Lengkap',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimen.x6),
                      ),
                      errorText: getErrorText(fullNameController)),
                  focusNode: _nameFocus,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (term) {
                    _nameFocus.unfocus();
                    FocusScope.of(context).requestFocus(_phoneFocus);
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
                  controller: phoneController,
                  decoration: InputDecoration(
                    prefixText: '+62 ',
                    labelText: 'Nomor Handphone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimen.x6),
                    ),
                    errorText: getErrorText(phoneController),
                  ),
                  keyboardType: TextInputType.phone,
                  autovalidate: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return null;
                    }
                    final n = num.tryParse(value);
                    if (n == null) {
                      return 'Masukkan hanya angka';
                    }
                    return null;
                  },
                  focusNode: _phoneFocus,
                  textInputAction: TextInputAction.done,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: Dimen.x8,
                  bottom: Dimen.x6,
                  left: Dimen.x16,
                  right: Dimen.x16,
                ),
                child: InkWell(
                  child: TextFormField(
                    controller: dobController,
                    decoration: InputDecoration(
                      labelText: 'Tanggal Lahir',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimen.x6),
                      ),
                    ),
                    enabled: false,
                  ),
                  onTap: () => onDoBClick(),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: Dimen.x8,
                  bottom: Dimen.x6,
                  left: Dimen.x16,
                  right: Dimen.x16,
                ),
                child: InkWell(
                  child: TextFormField(
                    controller: genderController,
                    decoration: InputDecoration(
                      labelText: 'Jenis Kelamin',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimen.x6),
                      ),
                    ),
                    enabled: false,
                  ),
                  onTap: () => onGenderClick(),
                ),
              ),
            ],
          ),
        ),
        StandardButton(
          text: 'Simpan',
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
