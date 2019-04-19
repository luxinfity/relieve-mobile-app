import "package:flutter/material.dart";
import "package:recase/recase.dart";
import 'package:relieve_app/service/model/location.dart';

import "package:relieve_app/widget/screen/call/components/item_button.dart";
import "package:relieve_app/res/res.dart";
import "package:relieve_app/widget/inherited/app_config.dart";
import "package:relieve_app/widget/common/title.dart";
import "package:relieve_app/service/model/contact.dart";
import "package:relieve_app/service/source/api/api.dart";
import "package:relieve_app/widget/common/relieve_scaffold.dart";
import "package:relieve_app/service/source/location.dart";
import "package:relieve_app/widget/common/standard_button.dart";

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
    // TODO: handle getCurrentLocation(...) null value
    final position = await LocationService.getCurrentLocation();
    final contactResponse = await BakauApi(AppConfig.of(context))
        .getNearbyEmergencyContact(Location.parseFromPosition(position));

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
      case "hospital":
        return LocalImage.ic_ambulance;
      case "police":
        return LocalImage.ic_police;
      case "fire_station":
        return LocalImage.ic_fire_fighter;
      case "red_cross":
        return LocalImage.ic_red_cross;
      case "bmkg":
        return LocalImage.ic_bmkg;
      case "sar":
        return LocalImage.ic_sar;
      case "bpjs":
        return LocalImage.ic_medic;
      case "pln":
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
        title: "Tambah Lainnya",
        isTintBlue: true,
        onClick: () {
          print("click");
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
        ThemedTitle(title: "Tentukan Panggilan Pilihanmu"),
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
                  text: "Simpan",
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
                child: Row(
                  children: <Widget>[
                    Container(width: Dimen.x16),
                    Expanded(
                      child: RaisedButton(
                        padding: EdgeInsets.only(
                          top: Dimen.x16,
                          bottom: Dimen.x16,
                        ),
                        elevation: 0,
                        highlightElevation: 0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Dimen.x4),
                            side: BorderSide(color: AppColor.colorPrimary)),
                        child: Text("Ubah Nomor Layanan"),
                        textColor: AppColor.colorPrimary,
                        onPressed: () {
                          setState(() {
                            isEditMode = true;
                          });
                        },
                      ),
                    ),
                    Container(width: Dimen.x12),
                    Expanded(
                      child: RaisedButton(
                        padding: EdgeInsets.only(
                          top: Dimen.x16,
                          bottom: Dimen.x16,
                        ),
                        elevation: 0,
                        highlightElevation: 0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Dimen.x4),
                            side: BorderSide(color: AppColor.colorPrimary)),
                        child: Text("Pilih Layanan Favorit"),
                        textColor: AppColor.colorPrimary,
                        onPressed: () {
                          setState(() {
                            isEditMode = true;
                          });
                        },
                      ),
                    ),
                    Container(width: Dimen.x16),
                  ],
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
