import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:relieve_app/datamodel/family.dart';
import 'package:relieve_app/res/res.dart';

enum FamilyItemType { Normal, Empty, Add }

class FamilyItem extends StatelessWidget {
  final FamilyItemType type;
  final Family family;
  final VoidCallback onClick;
  final bool hideName;

  const FamilyItem({
    Key key,
    this.type,
    this.family,
    this.onClick,
    this.hideName = false,
  }) : super(key: key);

  Widget _createNormalItem() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 3, color: _pickColorItem()),
      ),
      padding: EdgeInsets.all(2),
      height: Dimen.x64,
      width: Dimen.x64,
      child: ClipOval(
        child: Material(
          child: Ink.image(
            image: CachedNetworkImageProvider(family.imageUrl),
            fit: BoxFit.cover,
            child: InkWell(
              onTap: onClick,
            ),
          ),
        ),
      ),
    );
  }

  Color _pickColorItem() {
    if (family.condition == null ||
        family.condition.health == PersonHealth.None) {
      return HexColor(AppColor.colorEmptyRect.hexColor, transparency: 0.50);
    } else if (family.condition.health == PersonHealth.Bad) {
      return AppColor.colorDanger;
    } else {
      return AppColor.colorPrimary;
    }
  }

  Widget _createEmptyItem() {
    return Center(
      child: LocalImage.dashedCircle.toSvg(
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
          onTap: onClick,
          child: Container(
            height: Dimen.x64,
            width: Dimen.x64,
            child: Center(
              child: LocalImage.icAddUser.toSvg(
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
          Center(child: _createCircle()),
          hideName ? Container() : _createText(),
        ],
      ),
    );
  }

  FamilyItem.empty({
    this.family = const Family(fullName: 'Kerabat'),
    this.type = FamilyItemType.Empty,
    this.onClick,
    this.hideName = false,
  });

  FamilyItem.add({
    this.family = const Family(fullName: 'Tambah'),
    this.type = FamilyItemType.Add,
    this.onClick,
    this.hideName = false,
  });

  FamilyItem.normal({
    @required this.family,
    this.type = FamilyItemType.Normal,
    this.onClick,
    this.hideName = false,
  });
}
