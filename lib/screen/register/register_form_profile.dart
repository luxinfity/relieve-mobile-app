import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart";
import "package:relieve_app/res/res.dart";
import "package:relieve_app/widget/bottom_modal.dart";
import "package:relieve_app/widget/item/standard_button.dart";
import "package:relieve_app/widget/item/title.dart";
import "package:url_launcher/url_launcher.dart";

class RegisterFormProfile extends StatefulWidget {
  final VoidCallback onNextClick;

  const RegisterFormProfile({Key key, this.onNextClick}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RegisterFormProfileState();
  }
}

class RegisterFormProfileState extends State<RegisterFormProfile> {
  bool passwordVisible = false;

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();

  final genderController = TextEditingController();
  final dobController = TextEditingController();

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
      ThemedTitle(
        title: "Pilih jenis kelamin",
      ),
      StandardButton(
        text: "Perempuan",
        backgroundColor: Colors.blue,
        buttonClick: () {
          genderController.text = "Perempuan";
          Navigator.pop(context);
        },
      )
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
                title: "Data Diri",
                subtitle: "Beritahu kami mengenai diri kamu",
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: Dimen.x8,
                  bottom: Dimen.x6,
                  left: Dimen.x16,
                  right: Dimen.x16,
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Nama Lengkap",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimen.x6),
                    ),
                  ),
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
                  decoration: InputDecoration(
                    prefixText: "+62 ",
                    labelText: "Nomor Handphone",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimen.x6),
                    ),
                  ),
                  keyboardType: TextInputType.number,
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
                      labelText: "Tanggal Lahir",
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
                      labelText: "Jenis Kelamin",
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
          buttonClick: widget.onNextClick,
          backgroundColor: AppColor.colorPrimary,
        ),
        Container(
          height: Dimen.x16 + safePadding.bottom,
        )
      ],
    );
  }
}
