import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

import './components/item_button.dart';
import 'package:relieve_app/res/res.dart';
import 'package:relieve_app/app_config.dart';
import 'package:relieve_app/widget/item/title.dart';
import 'package:relieve_app/service/model/contact.dart';
import 'package:relieve_app/service/source/api/api.dart';
import 'package:relieve_app/widget/relieve_scaffold.dart';
import 'package:relieve_app/service/source/location.dart';
import 'package:relieve_app/widget/item/standard_button.dart';

class CallListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CallListScreenState();
  }
}

class CallListScreenState extends State {
  bool isEditMode = false;
  List<Contact> contactList = List<Contact>();
  List<bool> isSelectedList = [
    false,
    false,
    false,
    true,
    false,
    false,
    false,
    false,
  ];

  void getAllContact() async {
    final location = LocationService.gerCurrentLocation();
    final contactResponse = await BakauApi(AppConfig.of(context))
        .getNearbyEmergencyContact(location);

    if (contactResponse.status == REQUEST_SUCCESS) {
      setState(() {
        contactList = contactResponse.content;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getAllContact();
  }

  List<Widget> createContacts() {
    var buttons = contactList
        .map(
          (contact) => ItemButton(
                icon: LocalImage.ic_ambulance,
                title: ReCase(contact.type).titleCase,
                isEditMode: isEditMode,
                isSelected: isSelectedList[0],
                onClick: () => _onClickSelect(0),
              ),
        )
        .toList();
    buttons.insert(
      0,
      ItemButton(
        icon: LocalImage.ic_add_other,
        title: 'Tambah Lainnya',
        isTintBlue: true,
        onClick: () {},
      ),
    );
    return buttons;
    // return <Widget>[
    //   ItemButton(
    //     icon: LocalImage.ic_add_other,
    //     title: 'Tambah Lainnya',
    //     isTintBlue: true,
    //     onClick: () {},
    //   ),
    //   ItemButton(
    //     icon: LocalImage.ic_ambulance,
    //     title: 'Ambulance',
    //     isEditMode: isEditMode,
    //     isSelected: isSelectedList[0],
    //     onClick: () => _onClickSelect(0),
    //   ),
    //   ItemButton(
    //     icon: LocalImage.ic_police,
    //     title: 'Kantor Polisi',
    //     isEditMode: isEditMode,
    //     isSelected: isSelectedList[1],
    //     onClick: () => _onClickSelect(1),
    //   ),
    //   ItemButton(
    //     icon: LocalImage.ic_fire_fighter,
    //     title: 'Pemadam Kebakaran',
    //     isEditMode: isEditMode,
    //     isSelected: isSelectedList[2],
    //     onClick: () => _onClickSelect(2),
    //   ),
    //   ItemButton(
    //     icon: LocalImage.ic_red_cross,
    //     title: 'Palang Merah',
    //     isEditMode: isEditMode,
    //     isSelected: isSelectedList[3],
    //     onClick: () => _onClickSelect(3),
    //   ),
    //   ItemButton(
    //     icon: LocalImage.ic_bmkg,
    //     title: 'BMKG',
    //     isEditMode: isEditMode,
    //     isSelected: isSelectedList[4],
    //     onClick: () => _onClickSelect(4),
    //   ),
    //   ItemButton(
    //     icon: LocalImage.ic_sar,
    //     title: 'Badan SAR',
    //     isEditMode: isEditMode,
    //     isSelected: isSelectedList[5],
    //     onClick: () => _onClickSelect(5),
    //   ),
    //   ItemButton(
    //     icon: LocalImage.ic_medic,
    //     title: 'BPJS',
    //     isEditMode: isEditMode,
    //     isSelected: isSelectedList[6],
    //     onClick: () => _onClickSelect(6),
    //   ),
    //   ItemButton(
    //     icon: LocalImage.ic_pln,
    //     title: 'PLN',
    //     isEditMode: isEditMode,
    //     isSelected: isSelectedList[7],
    //     onClick: () => _onClickSelect(7),
    //   ),
    // ];
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;

    return RelieveScaffold(
      hasBackButton: true,
      crossAxisAlignment: CrossAxisAlignment.start,
      childs: <Widget>[
        ThemedTitle(title: 'Tentukan Panggilan Pilihanmu'),
        Expanded(
          child: GridView.count(
            padding: const EdgeInsets.symmetric(horizontal: Dimen.x12),
            crossAxisCount: 2,
            childAspectRatio: 2,
            crossAxisSpacing: Dimen.x6,
            mainAxisSpacing: Dimen.x6,
            children: createContacts(),
          ),
        ),
        isEditMode
            ? Padding(
                padding: EdgeInsets.only(bottom: Dimen.x16 + padding.bottom),
                child: StandardButton(
                  text: 'Simpan',
                  backgroundColor: AppColor.colorPrimary,
                  buttonClick: () {
                    setState(() {
                      isEditMode = false;
                    });
                  },
                ),
              )
            : Padding(
                padding: EdgeInsets.only(bottom: Dimen.x16 + padding.bottom),
                child: StandardButton(
                  text: 'Edit Layanan Pilihan',
                  isHollow: true,
                  backgroundColor: AppColor.colorPrimary,
                  textColor: AppColor.colorPrimary,
                  buttonClick: () {
                    setState(() {
                      isEditMode = true;
                    });
                  },
                ),
              ),
      ],
    );
  }

  void _onClickSelect(int index) {
    setState(() {
      isSelectedList[index] = !isSelectedList[index];
    });
  }
}
