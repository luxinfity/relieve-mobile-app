import 'package:flutter/material.dart';
import 'package:relieve_app/datamodel/profile.dart';
import 'package:relieve_app/res/export.dart';
import 'package:relieve_app/service/service.dart';
import 'package:relieve_app/utils/common_utils.dart';
import 'package:relieve_app/utils/preference_utils.dart';
import 'package:relieve_app/widget/common/bottom_modal.dart';
import 'package:relieve_app/widget/common/loading_dialog.dart';
import 'package:relieve_app/widget/common/relieve_scaffold.dart';
import 'package:relieve_app/widget/screen/register/form/form_account.dart';
import 'package:relieve_app/widget/screen/register/form/form_address.dart';
import 'package:relieve_app/widget/screen/register/form/form_profile.dart';
import 'package:relieve_app/widget/screen/walkthrough/walkthrough_screen.dart';

class RegisterScreen extends StatefulWidget {
  final int progressCount;
  final Profile initialData;

  RegisterScreen({this.progressCount = 1, this.initialData = const Profile()});

  @override
  State<StatefulWidget> createState() {
    return _RegisterScreenState();
  }
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isPermissionDenied = false;
  int progressCount = 1;
  int progressTotal = 3;

  Profile _user;

  @override
  void initState() {
    super.initState();
    _user = widget.initialData;
    progressCount = widget.progressCount;
  }

  /// redirect user to logged in screen
  void onRegisterSuccess() {
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
  void doRegister(Profile completeUser) async {
    RelieveLoadingDialog.show(context);

    // final user will be stored as is
    final isSuccess = await FirebaseAuthHelper.get().register(completeUser);

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
        return FormAccount(
          initialData: _user,
          onNextClick: (user) {
            setState(() {
              _user = user;
              progressCount += 1;
            });
          },
        );
      case 2:
        return FormProfile(
          initialData: _user,
          onNextClick: (user) {
            setState(() {
              _user = user;
              progressCount += 1;
            });
          },
        );
      default:
        return FormAddress(
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
    bool isGoogleLogin = await PreferenceUtils.get().isGoogleLogin();

    int limit = isGoogleLogin ? 2 : 1;

    if (progressCount > limit) {
      if (!mounted) return;
      setState(() {
        progressCount -= 1;
      });
    } else {
      defaultBackPressed(context);

      // clear google credential
      FirebaseAuthHelper.get().logout();
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
