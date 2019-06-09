import 'package:flutter/material.dart';
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

  RegisterScreen({this.progressCount = 1, this.initialData = const User()});

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

  /// only call this method after checking all field
  /// (param: completeUser) is correct
  /// the field will be stored as is
  void doRegister(User completeUser) async {
    RelieveLoadingDialog.show(context);

    final user = completeUser.copyWith(
      gender: completeUser.gender == 'Perempuan' ? 'f' : 'm',
    );

    // final user will be stored as is
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
          initialData: _user,
          onNextClick: (user) {
            _user = user;
            doRegister(_user);
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
