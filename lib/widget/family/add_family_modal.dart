import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:relieve_app/datamodel/family.dart';
import 'package:relieve_app/datamodel/profile.dart';
import 'package:relieve_app/datamodel/relieve_user.dart';
import 'package:relieve_app/res/export.dart';
import 'package:relieve_app/service/api/bakau/bakau_provider.dart';
import 'package:relieve_app/service/api/base/api.dart';
import 'package:relieve_app/service/firebase/firestore_helper.dart';
import 'package:relieve_app/widget/common/bottom_modal.dart';
import 'package:relieve_app/widget/common/standard_button.dart';

enum AddFamilyStep { Search, NotFound, Found, Confirmation, Naming, Finish }

class AddFamilyModal extends StatefulWidget {
  final VoidCallback onFinishClick;

  const AddFamilyModal({Key key, this.onFinishClick}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddFamilyModalState();
  }

  static Future showModal(BuildContext context) {
    return RelieveBottomModal.create(context, <Widget>[
      AddFamilyModal(
        onFinishClick: () {
          Navigator.of(context).pop(true);
        },
      )
    ]);
  }
}

class _AddFamilyModalState extends State<AddFamilyModal> {
  static const int CONFIRMATION_TIMEOUT = 300; // in second

  // text controller
  final _usernameController = TextEditingController();

  // timer
  Timer _confirmationTiming;
  int confirmationTimePassed = CONFIRMATION_TIMEOUT; // in second

  var step = AddFamilyStep.Search;

  RelieveUser family;

  String _printDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void findUsername(String username) async {
    final user = await FirestoreHelper.get()
        .findUserBy(ProfileIdentifier.username, username);

    if (!mounted) return;
    setState(() {
      if (user == null) {
        step = AddFamilyStep.NotFound;
      } else {
        step = AddFamilyStep.Found;
        family = user;
      }
    });
  }

  /// call only if user already found
  void requestFamilyAdd() async {
    if (family == null) throw StateError('Family is still not found');
    final addFamilyState =
        await Api.get().setProvider(BakauProvider()).addFamily(family);

    if (!mounted) return;
    switch (addFamilyState) {
      case AddFamilyState.PENDING:
        setState(() {
          step = AddFamilyStep.Confirmation;
        });
        break;
      case AddFamilyState.SUCCESS:
        // impossible state on add request
        throw StateError('BE respond succes without confirmation code');
        break;
      case AddFamilyState.CANCELED:
        // back-end got unknown error
        // or can't send confirmation code to other user
        // or current user's family quota exceeded
        // return to search step
        setState(() {
          step = AddFamilyStep.Search;
        });
        break;
    }
  }

  void confirmUserAddCode(String secretCode) async {
    final addFamilyState = await Api.get()
        .setProvider(BakauProvider())
        .confirmFamilyAuth(secretCode);

    if (!mounted) return;
    switch (addFamilyState) {
      case AddFamilyState.PENDING:
        setState(() {
//          step = AddFamilyStep.WrongCode;
        });
        break;
      case AddFamilyState.SUCCESS:
        // impossible state on add request
        setState(() {
          step = AddFamilyStep.Naming;
        });
        break;
      case AddFamilyState.CANCELED:
        // back-end got unknown error
        // or can't send confirmation code to other user
        // or current user's family quota exceeded
        // return to search step
        setState(() {
          step = AddFamilyStep.Search;
        });
        break;
    }
  }

  void putFamilyLabel(String label) async {
    final isSuccess = await Api.get()
        .setProvider(BakauProvider())
        .editFamilyLabel(family, label);

    if (!mounted || !isSuccess) return;
    setState(() {
      step = AddFamilyStep.Finish;
    });
  }

  void buttonNextClick(String value) {
    switch (step) {
      case AddFamilyStep.Search:
        findUsername(value);
        break;
      case AddFamilyStep.NotFound:
        findUsername(value);
        break;
      case AddFamilyStep.Found:
        _confirmationTiming = Timer.periodic(
          Duration(seconds: 1),
          (t) => setState(() {
                if (confirmationTimePassed > 0)
                  confirmationTimePassed -= 1;
                else {
                  confirmationTimePassed = CONFIRMATION_TIMEOUT;
                  _confirmationTiming.cancel();
                  confirmUserAddCode(value);
                }
              }),
        );
        requestFamilyAdd();
        break;
      case AddFamilyStep.Confirmation:
        confirmationTimePassed = CONFIRMATION_TIMEOUT;
        _confirmationTiming.cancel();
        confirmUserAddCode(value);
        break;
      case AddFamilyStep.Naming:
        putFamilyLabel(value);
        break;
      case AddFamilyStep.Finish:
        // don't need input value
        widget.onFinishClick();
        break;
    }
    setState(() {});
  }

  List<Widget> getSearchStep(bool isUserNameExist) {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimen.x16, vertical: Dimen.x12),
        child: Text(
          'Tambahkan keluarga mu',
          style: CircularStdFont.black.getStyle(size: Dimen.x21),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimen.x16, vertical: Dimen.x8),
        child: TextField(
          controller: _usernameController,
          decoration: InputDecoration(
              labelText: 'Tulis username / email',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(Dimen.x14),
                child: LocalImage.icSearch
                    .toSvg(width: Dimen.x18, height: Dimen.x18),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimen.x6),
              ),
              errorText: step == AddFamilyStep.NotFound
                  ? 'Opps.. user tidak ditemukan'
                  : null),
        ),
      ),
      Container(height: isUserNameExist ? Dimen.x16 : 0),
      isUserNameExist
          ? Row(
              children: <Widget>[
                Container(width: Dimen.x16),
                Center(
                  child: Container(
                    height: Dimen.x42,
                    width: Dimen.x42,
                    child: ClipOval(
                      child: Material(
                        child: Ink.image(
                          image: CachedNetworkImageProvider(
                              'https://blue.kumparan.com/kumpar/image/upload/fl_progressive,fl_lossy,c_fill,q_auto:best,w_640/v1511853177/jedac0gixzhcnuozw7c4.jpg'),
                          fit: BoxFit.cover,
                          child: InkWell(
                            onTap: null,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(width: Dimen.x16),
                Expanded(
                  child: Text(
                    ReCase(family?.profile?.fullName ?? '').titleCase,
                    style: CircularStdFont.medium.getStyle(size: Dimen.x18),
                  ),
                ),
                Container(width: Dimen.x16),
              ],
            )
          : Container(),
      Container(height: Dimen.x28),
      StandardButton(
        text: isUserNameExist ? 'Tambahkan ke Daftar' : 'Cari Username',
        backgroundColor: AppColor.colorPrimary,
        buttonClick: () =>
            buttonNextClick(_usernameController.value?.text ?? ''),
      )
    ];
  }

  List<Widget> getConfirmationStep() {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimen.x16, vertical: Dimen.x12),
        child: Text(
          'Menunggu Konfirmasi',
          style: CircularStdFont.black.getStyle(size: Dimen.x21),
        ),
      ),
      Container(height: Dimen.x32),
      Center(
        child: Text(
          _printDuration(Duration(seconds: confirmationTimePassed)),
          style: CircularStdFont.book
              .getStyle(size: Dimen.x21, color: AppColor.colorTextGrey),
        ),
      ),
      Container(height: Dimen.x24),
      StandardButton(
        text: 'Batal',
        backgroundColor: AppColor.colorPrimary,
        buttonClick: () => buttonNextClick(null),
      )
    ];
  }

  List<Widget> getNamingStep() {
    final nameController = TextEditingController();
    return <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimen.x16, vertical: Dimen.x12),
        child: Text(
          'Masukkan nama panggilan nya',
          style: CircularStdFont.black.getStyle(size: Dimen.x21),
        ),
      ),
      Container(height: Dimen.x16),
      Row(
        children: <Widget>[
          Container(width: Dimen.x16),
          Center(
            child: Container(
              height: Dimen.x64,
              width: Dimen.x64,
              child: ClipOval(
                child: Material(
                  child: Ink.image(
                    image: CachedNetworkImageProvider(
                        'https://blue.kumparan.com/kumpar/image/upload/fl_progressive,fl_lossy,c_fill,q_auto:best,w_640/v1511853177/jedac0gixzhcnuozw7c4.jpg'),
                    fit: BoxFit.cover,
                    child: InkWell(
                      onTap: null,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      Container(height: Dimen.x14),
      Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimen.x16, vertical: Dimen.x8),
        child: TextFormField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: 'Nama Panggilan',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimen.x6),
            ),
          ),
        ),
      ),
      Container(height: Dimen.x24),
      StandardButton(
        text: 'Simpan',
        backgroundColor: AppColor.colorPrimary,
        buttonClick: () => buttonNextClick(nameController.value?.text ?? ''),
      )
    ];
  }

  List<Widget> getSuccessStep() {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimen.x16, vertical: Dimen.x12),
        child: Text(
          'Yeay keluarga mu berhasil di tambahkan!!',
          style: CircularStdFont.black.getStyle(size: Dimen.x21),
        ),
      ),
      Container(height: Dimen.x24),
      RemoteImage.boardingLogin.toImage(height: 210),
      Container(height: Dimen.x24),
      StandardButton(
        text: 'Mulai Komunikasi!',
        backgroundColor: AppColor.colorPrimary,
        buttonClick: () => buttonNextClick(null),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    var children = [];
    switch (step) {
      case AddFamilyStep.Search:
        children = getSearchStep(false);
        break;
      case AddFamilyStep.NotFound:
        children = getSearchStep(false);
        break;
      case AddFamilyStep.Found:
        children = getSearchStep(true);
        break;
      case AddFamilyStep.Confirmation:
        children = getConfirmationStep();
        break;
      case AddFamilyStep.Naming:
        children = getNamingStep();
        break;
      case AddFamilyStep.Finish:
        children = getSuccessStep();
        break;
    }
    return ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: children
          ..add(Container(height: MediaQuery.of(context).viewInsets.bottom)));
  }
}
