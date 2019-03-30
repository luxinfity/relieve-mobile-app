import "package:flutter/material.dart";
import "package:relieve_app/screen/register/register_form_account.dart";
import "package:relieve_app/screen/register/register_form_profile.dart";
import "package:relieve_app/screen/register/register_form_address.dart";
import "package:relieve_app/utils/common_utils.dart";
import "package:relieve_app/utils/preference_utils.dart";
import "package:relieve_app/widget/relieve_scaffold.dart";

class RegisterScreen extends StatefulWidget {
  final int progressCount;

  RegisterScreen({this.progressCount = 0});

  @override
  State<StatefulWidget> createState() {
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen> {
  bool isPermissionDenied = false;
  int progressCount = 0;
  int progressTotal = 3;

  Account _account;
  Profile _profile;
  MapAddress _mapAddress;

  @override
  void initState() {
    super.initState();
    progressCount = widget.progressCount;
  }

  Widget createPage() {
    switch (progressCount) {
      case 0:
        return RegisterFormAccount(
          initialData: _account,
          onNextClick: (account) {
            setState(() {
              _account = account;
              progressCount += 1;
            });
          },
        );
      case 1:
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
            // TODO: Register
          },
        );
    }
  }

  void onBackButtonClick(context) async {
    String googleId = await getGoogleId();
    int limit = googleId.isEmpty ? 0 : 1;

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
      progressCount: progressCount == 3 ? 2 : progressCount,
      progressTotal: progressTotal,
      crossAxisAlignment: CrossAxisAlignment.start,
      onBackPressed: onBackButtonClick,
      childs: <Widget>[
        Expanded(child: createPage()),
      ],
    );
  }
}
