import 'package:flutter/material.dart';
import 'package:relieve_app/datamodel/address.dart';
import 'package:relieve_app/datamodel/location.dart';
import 'package:relieve_app/datamodel/map_address.dart';
import 'package:relieve_app/datamodel/user.dart';
import 'package:relieve_app/res/res.dart';
import 'package:relieve_app/service/service.dart';
import 'package:relieve_app/utils/common_utils.dart';
import 'package:relieve_app/utils/preference_utils.dart';
import 'package:relieve_app/widget/common/bottom_modal.dart';
import 'package:relieve_app/widget/common/loading_dialog.dart';
import 'package:relieve_app/widget/common/relieve_scaffold.dart';
import 'package:relieve_app/widget/screen/register/register_form_account.dart';
import 'package:relieve_app/widget/screen/register/register_form_address.dart';
import 'package:relieve_app/widget/screen/register/register_form_profile.dart';
import 'package:relieve_app/widget/screen/walkthrough/walkthrough.dart';

class RegisterScreen extends StatefulWidget {
  final int progressCount;
  final User initialData;

  RegisterScreen({this.progressCount = 1, this.initialData});

  @override
  State<StatefulWidget> createState() {
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen> {
  bool isPermissionDenied = false;
  int progressCount = 1;
  int progressTotal = 3;

  User _user;
  MapAddress _mapAddress;

  @override
  void initState() {
    super.initState();
    _user = widget.initialData;
    progressCount = widget.progressCount;
  }

  /// redirect user to logged in screen
  void onRegisterSuccess() {
    PreferenceUtils.setLogin(true);
    // auto login
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (builder) => WalkthroughScreen()),
      (_) => false, // clean all back stack
    );
  }

  void onRegisterFailed() {
    RelieveBottomModal.create(context, <Widget>[
      Container(height: Dimen.x21),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimen.x16),
        child: Text(
          'Username atau Email telah terdaftar',
          style: CircularStdFont.book.getStyle(size: Dimen.x16),
        ),
      ),
    ]);
  }

  void doRegister(MapAddress mapAddress) async {
    RelieveLoadingDialog.show(context);

    final location = mapAddress.coordinate.split(',');
    final user = User(
      username: _user.username,
      email: _user.email,
      password: _user.password,
      fullName: _user.fullName,
      phones: _user.phones,
      birthDate: _user.birthDate,
      gender: _user.gender == 'Perempuan' ? 'f' : 'm',
      address: Address(
        uuid: '1',
        location:
            Location(double.parse(location[0]), double.parse(location[1])),
        name: '${mapAddress.name}|${mapAddress.address}',
      ),
    );

    // TODO: check whether fields already filled
    final isSuccess = await FirebaseAuthHelper.instance.register(user);

    RelieveLoadingDialog.dismiss(context);

    if (isSuccess) {
      onRegisterSuccess();
    } else {
      onRegisterFailed();
    }
  }

  Widget createPage() {
    switch (progressCount) {
      case 1:
        return RegisterFormAccount(
          initialData: _user,
          onNextClick: (user) {
            setState(() {
              _user = user;
              progressCount += 1;
            });
          },
        );
      case 2:
        return RegisterFormProfile(
          initialData: _user,
          onNextClick: (user) {
            setState(() {
              _user = user;
              progressCount += 1;
            });
          },
        );
      default:
        return RegisterFormAddress(
          initialData: _mapAddress,
          onNextClick: (mapAddress) {
            _mapAddress = mapAddress;
            doRegister(mapAddress);
          },
        );
    }
  }

  /// pick back press flow
  /// if user register using google let user back until screen 2
  /// else let user back until screen 1
  void onBackButtonClick(context) async {
    bool isGoogleLogin = await PreferenceUtils.isGoogleLogin();

    int limit = isGoogleLogin ? 2 : 1;

    if (progressCount > limit) {
      setState(() {
        progressCount -= 1;
      });
    } else {
      defaultBackPressed(context);

      // clear google credential
      FirebaseAuthHelper.instance.logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RelieveScaffold(
      hasBackButton: true,
      progressCount: progressCount,
      progressTotal: progressTotal,
      crossAxisAlignment: CrossAxisAlignment.start,
      onBackPressed: onBackButtonClick,
      childs: <Widget>[
        Expanded(child: createPage()),
      ],
    );
  }
}
