import 'package:flutter/material.dart';

import '../../network/model/family.dart';
import '../../res/res.dart';

enum FamilyItemType { Normal, Empty, Add }

class FamilyItem extends StatelessWidget {
  final FamilyItemType type;
  final Family family;
  final VoidCallback onClick;

  const FamilyItem({
    Key key,
    this.type,
    this.family,
    this.onClick,
  }) : super(key: key);

  Widget _createNormalItem() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 3),
        color: Colors.blueAccent,
      ),
      padding: EdgeInsets.all(2),
      height: Dimen.x64,
      width: Dimen.x64,
      child: ClipOval(
        child: Material(
          child: Ink.image(
            image: NetworkImage(family.imageUrl),
            fit: BoxFit.cover,
            // height: 50,
            // width: 50,
            child: InkWell(
              onTap: onClick,
            ),
          ),
        ),
      ),
    );
  }

  Widget _createEmptyItem() {
    return Center(
      child: LocalImage.dashed_circle.toSvg(
        height: Dimen.x64,
        width: Dimen.x64,
      ),
    );
  }

  Widget _createAddItem() {
    return ClipOval(
      child: Material(
        color: AppColor.colorPrimary,
        child: InkWell(
          onTap: () {},
          child: Container(
            height: Dimen.x64,
            width: Dimen.x64,
            child: Center(
              child: LocalImage.ic_add_user.toSvg(
                height: Dimen.x18,
                width: Dimen.x18,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _createCircle() {
    switch (type) {
      case FamilyItemType.Normal:
        return _createNormalItem();
      case FamilyItemType.Add:
        return _createAddItem();
      default: // FamilyItemType.Empty
        return _createEmptyItem();
    }
  }

  Widget _createText() {
    return Padding(
      padding: const EdgeInsets.only(top: Dimen.x4),
      child: Text(
        family.fullName,
        style: CircularStdFont.medium.getStyle(
          color: (type == FamilyItemType.Empty)
              ? AppColor.colorTextGrey
              : AppColor.colorTextBlack,
          size: Dimen.x11,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: <Widget>[
            Center(child: _createCircle()),
            _createText(),
          ],
        ),
      ),
    );
  }

  FamilyItem.empty({
    this.family = const Family(fullName: 'Kerabat'),
    this.type = FamilyItemType.Empty,
    this.onClick,
  });

  FamilyItem.add({
    this.family = const Family(fullName: 'Tambah'),
    this.type = FamilyItemType.Add,
    this.onClick,
  });

  FamilyItem.normal({
    @required this.family,
    this.type = FamilyItemType.Normal,
    this.onClick,
  });
}

class FamilyItemList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FamilyItemListState();
  }
}

class FamilyItemListState extends State {
  List<Family> familyList = [
    Family(
      fullName: 'Ayah',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/Suzy_Bae_at_fansigning_on_February_3%2C_2018_%284%29.jpg/220px-Suzy_Bae_at_fansigning_on_February_3%2C_2018_%284%29.jpg',
    ),
    Family(
      fullName: 'Ibu',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/Suzy_Bae_at_fansigning_on_February_3%2C_2018_%284%29.jpg/220px-Suzy_Bae_at_fansigning_on_February_3%2C_2018_%284%29.jpg',
    ),
    Family(
      fullName: 'Kak dinda',
      imageUrl:
          'https://raw.githubusercontent.com/RelieveID/mobile-apps-assets/master/images/item_dinda.png',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      height: 100,
      width: double.infinity,
      padding: EdgeInsets.only(
        top: Dimen.x4,
        bottom: Dimen.x4,
      ),
      child: familyList.isNotEmpty ? _createFilledList() : _createEmptyList(),
    );

    // return familyList.isNotEmpty ? _createFilledList() : _createEmptyList();
  }

  Widget _createEmptyList() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Container(
          width: Dimen.x12,
        ),
        FamilyItem.empty(),
        FamilyItem.add(),
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
    content.add(FamilyItem.add());

    return ListView(
      // shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      children: content,
    );
  }

  void personClick(int position) {
    print(position);
  }
}
