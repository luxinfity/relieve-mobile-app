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
  final uniqueTypes = List<String>();
  List<bool> isSelectedList = List<bool>();

  void getAllContact() async {
    final location = LocationService.gerCurrentLocation();
    final contactResponse = await BakauApi(AppConfig.of(context))
        .getNearbyEmergencyContact(location);

    if (contactResponse?.status == REQUEST_SUCCESS) {
      setState(() {
        contactList = contactResponse.content;
        contactList.forEach((contact) {
          if (!uniqueTypes.contains(contact.type)) {
            uniqueTypes.add(contact.type);
          }
        });
        isSelectedList = List.generate(uniqueTypes.length, (index) => false);
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getAllContact();
  }

  LocalImage getIcon(String type) {
    switch (type) {
      case 'hospital':
        return LocalImage.ic_ambulance;
      case 'police':
        return LocalImage.ic_police;
      case 'fire_station':
        return LocalImage.ic_fire_fighter;
      case 'red_cross':
        return LocalImage.ic_red_cross;
      case 'bmkg':
        return LocalImage.ic_bmkg;
      case 'sar':
        return LocalImage.ic_sar;
      case 'bpjs':
        return LocalImage.ic_medic;
      case 'pln':
        return LocalImage.ic_pln;
      default:
        return LocalImage.ic_ambulance;
    }
  }

  List<Widget> createContacts() {
    var buttons = List.generate(
      uniqueTypes.length,
      (index) => ItemButton(
            icon: getIcon(uniqueTypes[index]),
            title: ReCase(uniqueTypes[index]).titleCase,
            isEditMode: isEditMode,
            isSelected: isSelectedList[index],
            onClick: () => _onClickSelect(index),
          ),
    );

    buttons.insert(
      0,
      ItemButton(
        icon: LocalImage.ic_add_other,
        title: 'Tambah Lainnya',
        isTintBlue: true,
        onClick: () {
          print('click');
        },
      ),
    );
    return buttons;
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
    if (isEditMode) {
      setState(() {
        isSelectedList[index] = !isSelectedList[index];
      });
    }
  }
}
