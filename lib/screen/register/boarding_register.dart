import "package:flutter/material.dart";
import "package:flutter/gestures.dart";
import "package:relieve_app/app_config.dart";
import "package:relieve_app/res/res.dart";
import "package:relieve_app/screen/walkthrough/walkthrough.dart";
import "package:relieve_app/service/model/user.dart";
import "package:relieve_app/service/service.dart";
import "package:relieve_app/utils/common_utils.dart";
import "package:relieve_app/widget/bottom_modal.dart";
import "package:relieve_app/widget/item/standard_button.dart";
import "package:relieve_app/widget/item/title.dart";
import "package:relieve_app/widget/relieve_scaffold.dart";
import "package:url_launcher/url_launcher.dart";
import "package:email_validator/email_validator.dart";
import "package:validators/validators.dart";
import "package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart";

import "package:relieve_app/utils/preference_utils.dart" as pref;

class BoardingRegisterScreen extends StatefulWidget {
  BoardingRegisterScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BoardingRegisterState();
  }
}

class BoardingRegisterState extends State {
  var steps = 0;
  var passwordVisible = false;
  var isSecondFormEmpty = false;
  var isThirdFormEmpty = false;

  // second step
  var isPhoneValid = true;
  final fullnameController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  final genderController = TextEditingController();

  // third step
  final lurahController = TextEditingController();
  final districtController = TextEditingController();
  final cityController = TextEditingController();
  final coordinateController = TextEditingController();

  void checkStep2() {
    setState(() {
      isSecondFormEmpty = [
        fullnameController,
        phoneController,
        dobController,
        genderController
      ].any((controller) => controller.text.isEmpty);

      isPhoneValid = isNumeric(phoneController.text) &&
          phoneController.text.replaceFirst("0", "").length >= 7;

      if (!isSecondFormEmpty && isPhoneValid) {
        steps = 2;
      }
    });
  }

  void checkStep3() {
    setState(() {
      isThirdFormEmpty = [
        lurahController,
        districtController,
        cityController,
        coordinateController
      ].any((controller) => controller.text.isEmpty);

      if (!isThirdFormEmpty) {
        doRegister();
      }
    });
  }

  void doRegister() async {
    final user = User(
      username: "",
      email: "",
      password: "",
      fullname: fullnameController.text,
      phones: [
        Phone("+62${phoneController.text.replaceFirst("0", "")}", 1),
      ],
      birthdate: dobController.text,
      gender: genderController.text == "Perempuan" ? "f" : "m",
    );

    final tokenResponse = await BakauApi(AppConfig.of(context)).register(user);

    if (tokenResponse?.status == REQUEST_SUCCESS) {
      await pref.setToken(tokenResponse.content.token);
      await pref.setRefreshToken(tokenResponse.content.refreshToken);
      await pref.setExpireIn(tokenResponse.content.expiresIn);
      await pref.setUsername("");
      onRegisterSuccess();
    } else {
      createRelieveBottomModal(context, <Widget>[
        Container(height: Dimen.x21),
        Text(
          "Username atau Email telah terdaftar",
          style: CircularStdFont.book.getStyle(size: Dimen.x21),
        ),
      ]);
    }
  }

  void onButtonClick() {
    switch (steps) {
      case 0:
//        checkStep1();
        break;
      case 1:
        checkStep2();
        break;
      default:
        checkStep3();
        break;
    }
  }

  void onRegisterSuccess() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (builder) => WalkthroughScreen()),
      (_) => false, // clean all back stack
    );
  }

  @override
  Widget build(BuildContext context) {
    final form = createForm()..add(buildTnCNotif() ?? Container());

    return RelieveScaffold(
      crossAxisAlignment: CrossAxisAlignment.start,
      hasBackButton: true,
      childs: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              createTitle(),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(0),
                  children: form,
                ),
              ),
              createButton(),
            ].where((widget) => widget != null).toList(),
          ),
        )
      ],
    );
  }

  Widget createTitle() {
    switch (steps) {
      case 0:
        return ThemedTitle(
          title: "Akun",
          subtitle: "Gunakan username kesukaan mu",
        );
      case 1:
        return ThemedTitle(
          title: "Data Diri",
          subtitle: "Beritahu kami mengenai diri kamu",
        );
      default:
        return ThemedTitle(
          title: "Alamat Tinggal",
          subtitle: "Selangkah lagi! Beritahu kami alamat mu",
        );
    }
  }

  Widget createButton() {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    return Padding(
      padding:
          EdgeInsets.only(top: Dimen.x8, bottom: Dimen.x16 + padding.bottom),
      child: StandardButton(
        text: steps == 0 || steps == 1 ? "Lanjut" : "Daftar",
        backgroundColor: AppColor.colorPrimary,
        buttonClick: () => onButtonClick(),
      ),
    );
  }

  List<Widget> createForm2() {
    return <Widget>[
      buildInputForm(
        key: "nameInput",
        label: "Nama Lengkap",
        controller: fullnameController,
        textInputAction: TextInputAction.next,
        errorTextGenerator: () {
          return isSecondFormEmpty && fullnameController.text.isEmpty
              ? "Silahkan diisi dulu"
              : null;
        },
      ),
      buildInputForm(
        key: "phoneInput",
        prefix: "+62 ",
        label: "Nomor Telpon",
        controller: phoneController,
        inputType: TextInputType.phone,
        textInputAction: TextInputAction.done,
        errorTextGenerator: () {
          if (isSecondFormEmpty && phoneController.text.isEmpty) {
            return "Silahkan diisi dulu";
          } else if (!isPhoneValid) {
            return "Masukkan hanya angka dan lebih dari 7";
          } else {
            return null;
          }
        },
      ),
      buildInputForm(
        key: "dobInput",
        label: "Tanggal Lahir",
        controller: dobController,
        inputType: TextInputType.datetime,
        onTap: () => onDoBClick(),
      ),
      buildInputForm(
        key: "genderInput",
        label: "Gender",
        controller: genderController,
        onTap: () => onGenderClick(),
      ),
    ];
  }

  List<Widget> createForm3() {
    return <Widget>[
      buildInputForm(
        key: "lurahInput",
        label: "Kelurahan",
        controller: lurahController,
        textInputAction: TextInputAction.next,
        errorTextGenerator: () {
          return isThirdFormEmpty && lurahController.text.isEmpty
              ? "Silahkan diisi dulu"
              : null;
        },
      ),
      buildInputForm(
        key: "districtInput",
        label: "Kecamatan",
        controller: districtController,
        inputType: TextInputType.text,
        textInputAction: TextInputAction.next,
        errorTextGenerator: () {
          return isThirdFormEmpty && districtController.text.isEmpty
              ? "Silahkan diisi dulu"
              : null;
        },
      ),
      buildInputForm(
        key: "cityInput",
        label: "Kabupaten / Kota",
        controller: cityController,
        textInputAction: TextInputAction.done,
        errorTextGenerator: () {
          return isThirdFormEmpty && cityController.text.isEmpty
              ? "Silahkan diisi dulu"
              : null;
        },
      ),
      buildInputForm(
        key: "coordinateInput",
        label: "Temukan dengan peta",
        controller: coordinateController,
        onTap: () => onMapClick(),
        rightIcon: LocalImage.ic_map.toSvg(height: Dimen.x18),
      ),
    ];
  }

  List<Widget> createForm() {
    switch (steps) {
      case 0:
//        return createForm1();
        return createForm2();
      case 1:
        return createForm2();
      default:
        return createForm3();
    }
  }

  void onDoBClick() {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      locale: "i18n",
      cancel: Text(
        "Batal",
        style: CircularStdFont.book.getStyle(
          size: Dimen.x12,
          color: AppColor.colorDanger,
        ),
      ),
      confirm: Text(
        "Pilih",
        style: CircularStdFont.book.getStyle(
          size: Dimen.x12,
          color: AppColor.colorPrimary,
        ),
      ),
      dateFormat: "yyyy-mm-dd",
      onConfirm: (year, month, date) {
        final monthStr = month.toString().padLeft(2, "0");
        final dateStr = date.toString().padLeft(2, "0");
        dobController.text = "$year-$monthStr-$dateStr";
      },
    );
  }

  void onGenderClick() {
    createRelieveBottomModal(context, <Widget>[
      Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimen.x4),
              ),
              padding: EdgeInsets.symmetric(vertical: Dimen.x16),
              textColor: Colors.white,
              child: Text(
                "Perempuan",
                style: CircularStdFont.medium.getStyle(
                  size: Dimen.x18,
                  color: AppColor.colorPrimary,
                ),
              ),
              onPressed: () {
                genderController.text = "Perempuan";
                Navigator.pop(context);
              },
            ),
          ),
          Container(width: Dimen.x12),
          Expanded(
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimen.x4),
              ),
              padding: EdgeInsets.symmetric(vertical: Dimen.x16),
              textColor: Colors.white,
              child: Text(
                "Laki - Laki",
                style: CircularStdFont.medium.getStyle(
                  size: Dimen.x18,
                  color: AppColor.colorPrimary,
                ),
              ),
              onPressed: () {
                genderController.text = "Laki - Laki";
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    ]);
  }

  void onMapClick() {}

  Widget buildInputForm({
    String key,
    String prefix,
    String label,
    bool obscureText = false,
    TextInputAction textInputAction,
    TextEditingController controller,
    TextInputType inputType,
    StringCallback errorTextGenerator,
    VoidCallback onTap,
    Widget rightIcon,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          top: Dimen.x8,
          bottom: Dimen.x6,
          left: Dimen.x16,
          right: Dimen.x16,
        ),
        child: TextFormField(
          key: Key(key),
          enabled: onTap == null,
          obscureText: obscureText && !passwordVisible,
          textInputAction: textInputAction,
          keyboardType: inputType,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimen.x6),
            ),
            prefixText: prefix,
            labelText: label,
            alignLabelWithHint: true,
            suffixIcon: obscureText
                ? IconButton(
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() => passwordVisible = !passwordVisible);
                    },
                  )
                : rightIcon != null
                    ? IconButton(
                        icon: rightIcon,
                        onPressed: () {
                          // setState(() => passwordVisible = !passwordVisible);
                        },
                      )
                    : null,
            errorText:
                (errorTextGenerator != null) ? errorTextGenerator() : null,
          ),
          controller: controller,
          maxLines: 1,
        ),
      ),
    );
  }

  Padding buildTnCNotif() {
    if (steps == 0 || steps == 1) {
      return null;
    } else {
      return Padding(
        padding: const EdgeInsets.only(
          left: Dimen.x32,
          right: Dimen.x32,
          top: Dimen.x64,
        ),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: "By registering you are accepting our ",
              style: CircularStdFont.book
                  .getStyle(size: Dimen.x14, color: AppColor.colorTextBlack),
              children: <TextSpan>[
                TextSpan(
                  text: "terms and condition",
                  style: CircularStdFont.book
                      .getStyle(size: Dimen.x14, color: AppColor.colorPrimary),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launch(
                          "https://github.com/RelieveID/terms-and-conditions/");
                    },
                ),
                TextSpan(text: " of use")
              ]),
        ),
      );
    }
  }
}
