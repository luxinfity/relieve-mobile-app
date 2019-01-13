import 'package:flutter/material.dart';

import '../../network/model/family.dart';
import '../../res/res.dart';

enum FamilyItemType { Normal, Empty, Add }

class FamilyItem extends StatelessWidget {
  final FamilyItemType type;
  final Family family;

  const FamilyItem({
    Key key,
    this.type,
    this.family,
  }) : super(key: key);

  Widget _createNormalItem() {
    return Center(
      child: LocalImage.dashed_circle.toSvg(
        height: Dimen.x64,
        width: Dimen.x64,
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
    return Padding(
      padding: const EdgeInsets.all(Dimen.x6),
      child: Column(
        children: <Widget>[
          Expanded(child: _createCircle()),
          _createText(),
        ],
      ),
    );
  }

  FamilyItem.empty({
    this.family = const Family(fullName: 'Kerabat'),
    this.type = FamilyItemType.Empty,
  });

  FamilyItem.add({
    this.family = const Family(fullName: 'Tambah'),
    this.type = FamilyItemType.Add,
  });

  FamilyItem.normal({
    @required this.family,
    this.type = FamilyItemType.Normal,
  });
}

class FamilyItemList extends StatelessWidget {
  final List<Family> familyList;

  const FamilyItemList({
    Key key,
    @required this.familyList, // default is empty
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      padding: EdgeInsets.only(
        top: Dimen.x4,
        bottom: Dimen.x4,
      ),
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
        FamilyItem.add(),
      ],
    );
  }

  Widget _createFilledList() {
    final content =
        // familyList.map((fam) => FamilyItem.normal(family: fam)).toList();
        familyList.map((fam) => FamilyItem.normal(family: fam)).toList();
    content.add(FamilyItem.add());

    return ListView(
      scrollDirection: Axis.horizontal,
      children: content,
    );
  }
}
