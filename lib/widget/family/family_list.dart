import 'package:flutter/material.dart';
import 'package:relieve_app/res/res.dart';
import 'package:relieve_app/service/model/family.dart';
import 'package:relieve_app/service/service.dart';
import 'package:relieve_app/service/source/api/bakau/bakau_provider.dart';
import 'package:relieve_app/widget/family/add_family_modal.dart';
import 'package:relieve_app/widget/family/family_item.dart';

class FamilyItemList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FamilyItemListState();
  }
}

class FamilyItemListState extends State {
  List<Family> familyList = [];

  void loadFamilyList() async {
    final response = await Api.get().setProvider(BakauProvider()).getFamilies();
    if (response?.status == REQUEST_SUCCESS && response?.content != null) {
      setState(() {
        familyList = response?.content;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadFamilyList();
  }

//  List<Family> _defaultFamilyList = [
//    Family(
//      fullName: 'Ayah',
//      condition: Condition(health: PersonHealth.Fine),
//      imageUrl:
//          'https://blue.kumparan.com/kumpar/image/upload/fl_progressive,fl_lossy,c_fill,q_auto:best,w_640/v1511853177/jedac0gixzhcnuozw7c4.jpg',
//    ),
//    Family(
//      fullName: 'Ibu',
//      condition: Condition(health: PersonHealth.Bad),
//      imageUrl:
//          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/Suzy_Bae_at_fansigning_on_February_3%2C_2018_%284%29.jpg/220px-Suzy_Bae_at_fansigning_on_February_3%2C_2018_%284%29.jpg',
//    ),
//    Family(
//      fullName: 'Kak dinda',
//      condition: Condition(health: PersonHealth.None),
//      imageUrl:
//          'https://www.sbs.com.au/popasia/sites/sbs.com.au.popasia/files/styles/full/public/twice-tzuyu-7.jpg',
//    )
//  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 94,
      width: double.infinity,
      child: familyList.isNotEmpty ? _createFilledList() : _createEmptyList(),
    );
  }

  Widget _createEmptyList() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Container(
          width: Dimen.x12,
        ),
        FamilyItem.empty(),
        FamilyItem.add(onClick: addFamilyClick),
        Container(width: Dimen.x12),
      ],
    );
  }

  Widget _createFilledList() {
    List<Widget> content = [
      Container(
        width: Dimen.x12,
      ),
    ];
    familyList.asMap().forEach((index, fam) => content.add(
          FamilyItem.normal(
            family: fam,
            onClick: () => personClick(index),
          ),
        ));
    content.addAll([
      FamilyItem.add(),
      Container(width: Dimen.x12),
    ]);

    return ListView(
      scrollDirection: Axis.horizontal,
      children: content,
    );
  }

  void addFamilyClick() {
    AddFamilyModal.showModal(context, () {});
  }

  void personClick(int position) {
//    setState(() {
//      if (position == 0) {
//        familyList = [];
//      } else if (position == 1) {
////        testSheet3(context);
//      } else if (position == 2) {
////        testSheet(context);
//      }
//    });
  }
}
