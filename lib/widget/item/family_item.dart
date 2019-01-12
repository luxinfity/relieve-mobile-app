import 'package:flutter/material.dart';
import 'package:dashed_circle/dashed_circle.dart';

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
      child: Text('Normal'),
    );
  }

  Widget _createEmptyItem() {
    return Center(
      child: LocalImage.dashed_circle.toSvg(
        height: 64,
        width: 64,
      ),
    );
  }

  Widget _createAddItem() {
    return Center(
      child: Text('Add'),
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
    return Text(
      family.fullName,
      style: CircularStdFont.medium.getStyle(
        color: (type == FamilyItemType.Empty)
            ? AppColor.colorTextGrey
            : AppColor.colorTextBlack,
        size: Dimen.x11,
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
    this.familyList = const [], // default is empty
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyanAccent,
      height: 100,
      width: double.infinity,
      padding: EdgeInsets.only(top: Dimen.x4, bottom: Dimen.x4),
      child: familyList.isNotEmpty ? _createFilledList() : _createEmptyList(),
    );
  }

  Widget _createEmptyList() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        FamilyItem.empty(),
        FamilyItem.add(),
      ],
    );
  }

  Widget _createFilledList() {
    return ListView(
      children: <Widget>[
        FamilyItem.empty(),
      ],
    );
  }
}
