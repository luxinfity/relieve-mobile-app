import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:relieve_app/res/export.dart';
import 'package:relieve_app/widget/common/bottom_modal.dart';
import 'package:relieve_app/widget/common/standard_button.dart';

class AddFamilyModal extends StatefulWidget {
  final VoidCallback onFinishClick;

  const AddFamilyModal({Key key, this.onFinishClick}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddFamilyModalState();
  }

  static showModal(BuildContext context, VoidCallback onExitModal) {
    RelieveBottomModal.create(
      context,
      <Widget>[
        AddFamilyModal(
          onFinishClick: () {
            Navigator.pop(context);
//          setState(() {
//            familyList = _defaultFamilyList;
//          });
          },
        )
      ],
      onWillPop: onExitModal,
    );
  }
}

enum AddPersonStep { Search, Found, Confirmation, Naming, Finish }

class _AddFamilyModalState extends State<AddFamilyModal> {
  var step = AddPersonStep.Search;
  final _usernameController = TextEditingController();
  var friendUsername = '';
  var friendSearchFound = true;

  /// return true if friend found
//  bool setFriendUsername(UserCheckResponse checkResponse) {
//    if (checkResponse?.status == REQUEST_SUCCESS &&
//        checkResponse?.content?.isExsist == true) {
//      debugLog(_AddFamilyModalState).info(checkResponse?.content?.value);
//      friendUsername = checkResponse?.content?.value;
//      return true;
//    }
//    return false;
//  }

  void findUsername(String username) async {
//    var checkResponse = await Api.get()
//        .setProvider(BakauProvider())
//        .isUserExist(UserCheckIdentifier.username, username);
//
//    var found = setFriendUsername(checkResponse);
//
//    debugLog(AddFamilyModalState).info(found);
//    if (!found) {
//      checkResponse = await Api.get()
//          .setProvider(BakauProvider())
//          .isUserExist(UserCheckIdentifier.email, username);
//      found = setFriendUsername(checkResponse);
//    }
//    setState(() {
//      friendSearchFound = found;
//      if (found) {
//        step = AddPersonStep.Found;
//      }
//    });
  }

  void buttonClick() {
    switch (step) {
      case AddPersonStep.Search:
        findUsername(_usernameController.value.text);
        break;
      case AddPersonStep.Found:
        step = AddPersonStep.Confirmation;
        break;
      case AddPersonStep.Confirmation:
        step = AddPersonStep.Naming;
        break;
      case AddPersonStep.Naming:
        step = AddPersonStep.Finish;
        break;
      case AddPersonStep.Finish:
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
        child: TextFormField(
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
              errorText:
                  friendSearchFound ? null : 'Opps.. user tidak ditemukan'),
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
                    friendUsername,
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
        buttonClick: buttonClick,
      )
    ];
  }

  List<Widget> getConfirmationStep() {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimen.x16, vertical: Dimen.x12),
        child: Text(
          'Masukkan kode unik',
          style: CircularStdFont.black.getStyle(size: Dimen.x21),
        ),
      ),
      Container(height: Dimen.x32),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: Dimen.x42,
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimen.x6),
                ),
              ),
            ),
          ),
          Container(width: Dimen.x16),
          Container(
            width: Dimen.x42,
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimen.x6),
                ),
              ),
            ),
          ),
          Container(width: Dimen.x16),
          Container(
            width: Dimen.x42,
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimen.x6),
                ),
              ),
            ),
          ),
          Container(width: Dimen.x16),
          Container(
            width: Dimen.x42,
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimen.x6),
                ),
              ),
            ),
          ),
          Container(width: Dimen.x16),
          Container(
            width: Dimen.x42,
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimen.x6),
                ),
              ),
            ),
          ),
        ],
      ),
      Container(height: Dimen.x18),
      Center(
        child: Text(
          '05:00',
          style: CircularStdFont.book
              .getStyle(size: Dimen.x12, color: AppColor.colorTextGrey),
        ),
      ),
      Container(height: Dimen.x24),
      StandardButton(
        text: 'Simpan',
        backgroundColor: AppColor.colorPrimary,
        buttonClick: buttonClick,
      )
    ];
  }

  List<Widget> getNamingStep() {
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
        buttonClick: buttonClick,
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
        buttonClick: buttonClick,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    var children = [];
    switch (step) {
      case AddPersonStep.Search:
        children = getSearchStep(false);
        break;
      case AddPersonStep.Found:
        children = getSearchStep(true);
        break;
      case AddPersonStep.Confirmation:
        children = getConfirmationStep();
        break;
      case AddPersonStep.Naming:
        children = getNamingStep();
        break;
      case AddPersonStep.Finish:
        children = getSuccessStep();
        break;
    }
    return ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: children);
  }
}
