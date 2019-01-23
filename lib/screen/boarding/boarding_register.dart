import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../res/res.dart';
import '../../widget/item/title.dart';
import '../../widget/item/standard_button.dart';
import '../walkthrough/walkthrough.dart';
import '../../widget/relieve_scaffold.dart';
import '../../utils/common_utils.dart';

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
  var isFirstFormEmpty = false;
  var isSecondFormEmpty = false;

  // first step
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // second step
  final fullnameController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  final genderController = TextEditingController();

  void onButtonClick(BuildContext context) {
    if (steps == 0) {
      setState(() {
        isFirstFormEmpty = [
          emailController,
          usernameController,
          passwordController,
          confirmPasswordController
        ].any((controller) => controller.text.isEmpty);

        if (!isFirstFormEmpty) {
          steps = 1;
        }
      });
    } else {
      setState(() {
        isSecondFormEmpty = [
          fullnameController,
          phoneController,
          dobController,
          genderController
        ].any((controller) => controller.text.isEmpty);

        if (!isSecondFormEmpty) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) => WalkthroughScreen()),
            (_) => false, // clean all back stack
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = <Widget>[
      createTitle(),
      Expanded(
        child: Container(),
      ),
      buildTnCNotif(),
      createButton(),
    ].where((widget) => widget != null).toList();

    // add forms
    children.insertAll(1, createForm());

    return RelieveScaffold(
        crossAxisAlignment: CrossAxisAlignment.start,
        hasBackButton: true,
        childs: children);
  }

  Widget createTitle() {
    if (steps == 0) {
      return ThemedTitle(title: 'Cukup isi data dibawah');
    } else {
      return ThemedTitle(title: 'Beritahu kami mengenai kamu');
    }
  }

  Widget createButton() {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    return Padding(
      padding:
          EdgeInsets.only(top: Dimen.x8, bottom: Dimen.x16 + padding.bottom),
      child: StandardButton(
        text: steps == 0 ? 'Lanjut' : 'Daftar',
        backgroundColor: AppColor.colorPrimary,
        buttonClick: () => onButtonClick(context),
      ),
    );
  }

  List<Widget> createForm() {
    if (steps == 0) {
      return <Widget>[
        buildInputForm(
          key: 'emailInput',
          label: 'Email',
          controller: emailController,
          errorTextGenerator: () {
            return isFirstFormEmpty && emailController.text.isEmpty
                ? 'Silahkan diisi dulu'
                : null;
          },
        ),
        buildInputForm(
          key: 'usernameInput',
          label: 'Username',
          controller: usernameController,
          errorTextGenerator: () {
            return isFirstFormEmpty && usernameController.text.isEmpty
                ? 'Silahkan diisi dulu'
                : null;
          },
        ),
        buildInputForm(
          key: 'passwordInput',
          label: 'Password',
          obscureText: true,
          controller: passwordController,
          errorTextGenerator: () {
            return isFirstFormEmpty && passwordController.text.isEmpty
                ? 'Silahkan diisi dulu'
                : null;
          },
        ),
        buildInputForm(
          key: 'confirmPassInput',
          label: 'Ketik Ulang Password',
          obscureText: true,
          controller: confirmPasswordController,
          errorTextGenerator: () {
            return isFirstFormEmpty && confirmPasswordController.text.isEmpty
                ? 'Silahkan diisi dulu'
                : null;
          },
        ),
      ];
    } else {
      return <Widget>[
        buildInputForm(
          key: 'nameInput',
          label: 'Nama Lengkap',
          controller: fullnameController,
          errorTextGenerator: () {
            return isSecondFormEmpty && fullnameController.text.isEmpty
                ? 'Silahkan diisi dulu'
                : null;
          },
        ),
        buildInputForm(
          key: 'phoneInput',
          prefix: '+62 ',
          label: 'Nomor Telpon',
          controller: phoneController,
          errorTextGenerator: () {
            return isSecondFormEmpty && phoneController.text.isEmpty
                ? 'Silahkan diisi dulu'
                : null;
          },
        ),
        buildInputForm(
          key: 'dobInput',
          label: 'Tanggal Lahir',
          controller: dobController,
          errorTextGenerator: () {
            return isSecondFormEmpty && dobController.text.isEmpty
                ? 'Silahkan diisi dulu'
                : null;
          },
        ),
        buildInputForm(
          key: 'genderInput',
          label: 'Gender',
          controller: genderController,
          errorTextGenerator: () {
            return isSecondFormEmpty && genderController.text.isEmpty
                ? 'Silahkan diisi dulu'
                : null;
          },
        ),
      ];
    }
  }

  Container buildInputForm({
    String key,
    String prefix,
    String label,
    bool obscureText = false,
    TextEditingController controller,
    StringCallback errorTextGenerator,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        top: Dimen.x6,
        left: Dimen.x24,
        right: Dimen.x24,
      ),
      child: TextFormField(
        key: Key(key),
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixText: prefix,
          labelText: label,
          suffixIcon: obscureText
              ? IconButton(
                  icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() => passwordVisible = !passwordVisible);
                  },
                )
              : null,
          errorText: (errorTextGenerator != null) ? errorTextGenerator() : null,
        ),
        controller: controller,
        maxLines: 1,
      ),
    );
  }

  Padding buildTnCNotif() {
    if (steps == 0) {
      return null;
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: Dimen.x32, right: Dimen.x32),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: 'By registering you are accepting our ',
              style: CircularStdFont.book
                  .getStyle(size: Dimen.x14, color: AppColor.colorTextBlack),
              children: <TextSpan>[
                TextSpan(
                  text: 'terms and condition',
                  style: CircularStdFont.book
                      .getStyle(size: Dimen.x14, color: AppColor.colorPrimary),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launch(
                          'https://github.com/RelieveID/terms-and-conditions/');
                    },
                ),
                TextSpan(text: ' of use')
              ]),
        ),
      );
    }
  }
}
