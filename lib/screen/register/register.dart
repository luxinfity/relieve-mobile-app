import "package:flutter/material.dart";
import "package:relieve_app/config/app_config.dart";
import "package:relieve_app/res/res.dart";
import "package:relieve_app/screen/register/register_form_account.dart";
import "package:relieve_app/screen/register/register_form_address.dart";
import "package:relieve_app/screen/register/register_form_profile.dart";
import "package:relieve_app/screen/walkthrough/walkthrough.dart";
import "package:relieve_app/service/model/address.dart";
import "package:relieve_app/service/model/location.dart";
import "package:relieve_app/service/model/user.dart";
import "package:relieve_app/service/service.dart";
import "package:relieve_app/utils/common_utils.dart";
import "package:relieve_app/utils/preference_utils.dart";
import "package:relieve_app/utils/preference_utils.dart" as pref;
import "package:relieve_app/widget/common/bottom_modal.dart";
import "package:relieve_app/widget/common/loading_dialog.dart";
import "package:relieve_app/widget/common/relieve_scaffold.dart";

class RegisterScreen extends StatefulWidget {
  final int progressCount;
  final Account initialData;

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

  Account _account;
  Profile _profile;
  MapAddress _mapAddress;

  @override
  void initState() {
    super.initState();
    _account = widget.initialData;
    progressCount = widget.progressCount;
  }

  void onRegisterSuccess() {
    // auto login
    pref.setUsername(_account.username);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (builder) => WalkthroughScreen()),
      (_) => false, // clean all back stack
    );
  }

  void doRegister(MapAddress mapAddress) async {
    showLoadingDialog(context);
    final location = mapAddress.coordinate.split(",");
    final user = User(
      username: _account.username,
      email: _account.email,
      password: _account.password,
      fullname: _profile.fullName,
      phones: <Phone>[Phone("+62${_profile.phoneNum}", 1)],
      birthdate: _profile.dob,
      isComplete: false,
      gender: _profile.gender == "Perempuan" ? "f" : "m",
      address: Address(
        uuid: "1",
        location:
            Location(double.parse(location[0]), double.parse(location[1])),
        name: "${mapAddress.name}|${mapAddress.address}",
      ),
    );

    final tokenResponse = await BakauApi(AppConfig.of(context)).register(user);
    dismissLoadingDialog(context);

    if (tokenResponse?.status == REQUEST_SUCCESS) {
      pref.setToken(tokenResponse.content.token);
      pref.setRefreshToken(tokenResponse.content.refreshToken);
      pref.setExpireIn(tokenResponse.content.expiresIn);

      onRegisterSuccess();
    } else {
      createRelieveBottomModal(context, <Widget>[
        Container(height: Dimen.x21),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimen.x16),
          child: Text(
            "Username atau Email telah terdaftar",
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
          initialData: _account,
          onNextClick: (account) {
            setState(() {
              _account = account;
              progressCount += 1;
            });
          },
        );
      case 2:
        return RegisterFormProfile(
          initialData: _profile,
          onNextClick: (profile) {
            setState(() {
              _profile = profile;
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
    String googleId = await getGoogleId();
    int limit = googleId.isEmpty ? 1 : 2;

    if (progressCount > limit) {
      setState(() {
        progressCount -= 1;
      });
    } else {
      defaultBackPressed(context);

      // remove google data
      if (googleId.isNotEmpty) {
        googleSignInScope.signOut();
        clearData();
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
