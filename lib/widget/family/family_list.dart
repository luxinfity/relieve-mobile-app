import 'package:flutter/material.dart';
import 'package:relieve_app/datamodel/family.dart';
import 'package:relieve_app/res/res.dart';
import 'package:relieve_app/service/api/base.dart';
import 'package:relieve_app/widget/family/add_family_modal.dart';
import 'package:relieve_app/widget/family/family_item.dart';

class FamilyItemList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FamilyItemListState();
  }
}

class FamilyItemListState extends State {
  // TODO: clean up last before release
//  static const List<Family> _defaultFamilyList = const [
//    Family(
//      uid: '',
//      profile: Profile(
//        fullName: 'Ayah',
//        imageUrl:
//            'https://blue.kumparan.com/kumpar/image/upload/fl_progressive,fl_lossy,c_fill,q_auto:best,w_640/v1511853177/jedac0gixzhcnuozw7c4.jpg',
//      ),
//      condition: Condition(health: Health.Fine),
//    ),
//    Family(
//      uid: '',
//      profile: Profile(
//        fullName: 'Ibu',
//        imageUrl:
//            'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/Suzy_Bae_at_fansigning_on_February_3%2C_2018_%284%29.jpg/220px-Suzy_Bae_at_fansigning_on_February_3%2C_2018_%284%29.jpg',
//      ),
//      condition: Condition(health: Health.Bad),
//    ),
//    Family(
//      uid: '',
//      profile: Profile(
//        fullName: 'Kak dinda',
//        imageUrl:
//            'https://www.sbs.com.au/popasia/sites/sbs.com.au.popasia/files/styles/full/public/twice-tzuyu-7.jpg',
//      ),
//      condition: Condition(health: Health.None),
//    )
//  ];

  List<Family> familyList = const [];

  void loadFamilyList() async {
    final families =
        await Api.get().setProvider(BakauProvider()).getFamilies() ?? const [];
    if (!mounted) return;
    setState(() {
      familyList = families;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadFamilyList();
  }

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
