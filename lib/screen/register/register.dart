import "package:flutter/material.dart";
import "package:permission_handler/permission_handler.dart";
import "package:relieve_app/screen/no_permission_location.dart";
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

  Future<bool> checkPermissionDenied() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);

    // print(permission == PermissionStatus.granted);
    // print(permission == PermissionStatus.restricted);
    // print(permission == PermissionStatus.denied);
    // print(permission == PermissionStatus.disabled);
    // print(permission == PermissionStatus.unknown);

    bool hasNoPermission = permission == PermissionStatus.denied ||
        permission == PermissionStatus.unknown;

    if (Theme.of(context).platform == TargetPlatform.iOS && hasNoPermission) {
      isPermissionDenied = true;
    } else {
      isPermissionDenied = false;
    }

    return isPermissionDenied;
  }

  @override
  void initState() {
    super.initState();
    progressCount = widget.progressCount;
  }

  Widget createPage() {
    switch (progressCount) {
      case 0:
        return RegisterFormAccount(
          onNextClick: () {
            setState(() {
              progressCount += 1;
            });
          },
        );
      case 1:
        return RegisterFormProfile(
          onNextClick: () async {
            bool isPermissionDenied = await checkPermissionDenied();
            setState(() {
              if (isPermissionDenied) {
                progressCount = 3;
              } else {
                progressCount += 1;
              }
            });
          },
        );
      case 2:
        return RegisterFormAddress(
          onBackClick: onBackButtonClick,
          onNextClick: () {
            setState(() {
              progressCount += 1;
            });
          },
        );
      default:
        return LocationPermissionScreen(
          onPermissionGranted: () {
            setState(() {
              progressCount = 2;
            });
          },
        );
    }
  }

  bool isHasBackButton(int progressCount) {
    switch (progressCount) {
      case 2:
        return false;
      default:
        return true;
    }
  }

  void onBackButtonClick(context) async {
    String googleId = await getGoogleId();
    int limit = googleId.isEmpty ? 0 : 1;

    if (progressCount == 3) {
      setState(() {
        progressCount = 1;
      });
    } else if (progressCount > limit) {
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
      hasBackButton: isHasBackButton(progressCount),
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
