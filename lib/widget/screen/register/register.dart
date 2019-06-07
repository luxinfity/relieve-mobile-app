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

  void onRegisterSuccess() {
    // auto login
    PreferenceUtils.setUsername(_user.username);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (builder) => WalkthroughScreen()),
      (_) => false, // clean all back stack
    );
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
      isComplete: false,
      gender: _user.gender == 'Perempuan' ? 'f' : 'm',
      address: Address(
        uuid: '1',
        location:
            Location(double.parse(location[0]), double.parse(location[1])),
        name: '${mapAddress.name}|${mapAddress.address}',
      ),
    );

    final tokenResponse =
        await Api.get().setProvider(BakauProvider()).register(user);

    RelieveLoadingDialog.dismiss(context);

    if (tokenResponse?.status == REQUEST_SUCCESS) {
      PreferenceUtils.setToken(tokenResponse.content.token);
      PreferenceUtils.setRefreshToken(tokenResponse.content.refreshToken);
      PreferenceUtils.setExpireIn(tokenResponse.content.expiresIn);

      onRegisterSuccess();
    } else {
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

  void onBackButtonClick(context) async {
    String googleId = await PreferenceUtils.getGoogleId();
    int limit = googleId.isEmpty ? 1 : 2;

    if (progressCount > limit) {
      setState(() {
        progressCount -= 1;
      });
    } else {
      defaultBackPressed(context);

      // remove google data
      if (googleId.isNotEmpty) {
        // googleSignInScope.signOut();
        PreferenceUtils.clearData();
      }
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
