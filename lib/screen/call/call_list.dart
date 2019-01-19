import 'package:flutter/material.dart';

import '../../res/res.dart';
import '../../widget/relieve_scaffold.dart';
import '../../widget/item/title.dart';
import '../../widget/item/standard_button.dart';
import './components/item_button.dart';

class CallListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CallListScreenState();
  }
}

class CallListScreenState extends State {
  bool isEditMode = false;
  List<bool> isSelectedList = [
    false,
    false,
    false,
    false,
    false,
    false,
    true,
    false,
  ];

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
            children: <Widget>[
              ItemButton(
                icon: LocalImage.ic_add_other,
                title: 'Tambah Lainnya',
                isTintBlue: true,
                onClick: () {},
              ),
              ItemButton(
                icon: LocalImage.ic_ambulance,
                title: 'Ambulance',
                isEditMode: isEditMode,
                isSelected: isSelectedList[0],
                onClick: () => _onClickSelect(0),
              ),
              ItemButton(
                icon: LocalImage.ic_police,
                title: 'Kantor Polisi',
                isEditMode: isEditMode,
                isSelected: isSelectedList[1],
                onClick: () => _onClickSelect(1),
              ),
              ItemButton(
                icon: LocalImage.ic_fire_fighter,
                title: 'Pemadam Kebakaran',
                isEditMode: isEditMode,
                isSelected: isSelectedList[2],
                onClick: () => _onClickSelect(2),
              ),
              ItemButton(
                icon: LocalImage.ic_red_cross,
                title: 'Palang Merah',
                isEditMode: isEditMode,
                isSelected: isSelectedList[3],
                onClick: () => _onClickSelect(3),
              ),
              ItemButton(
                icon: LocalImage.ic_bmkg,
                title: 'BMKG',
                isEditMode: isEditMode,
                isSelected: isSelectedList[4],
                onClick: () => _onClickSelect(4),
              ),
              ItemButton(
                icon: LocalImage.ic_sar,
                title: 'Badan SAR',
                isEditMode: isEditMode,
                isSelected: isSelectedList[5],
                onClick: () => _onClickSelect(5),
              ),
              ItemButton(
                icon: LocalImage.ic_medic,
                title: 'BPJS',
                isEditMode: isEditMode,
                isSelected: isSelectedList[6],
                onClick: () => _onClickSelect(6),
              ),
              ItemButton(
                icon: LocalImage.ic_pln,
                title: 'PLN',
                isEditMode: isEditMode,
                isSelected: isSelectedList[7],
                onClick: () => _onClickSelect(7),
              ),
            ],
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
