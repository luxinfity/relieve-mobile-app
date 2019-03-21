import 'package:flutter/material.dart';
import 'package:relieve_app/res/res.dart';
import 'package:relieve_app/service/model/family.dart';
import 'package:relieve_app/widget/bottom_modal.dart';
import 'package:relieve_app/widget/item/standard_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
            image: NetworkImage(family.imageUrl),
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
    if (family.personHealth == null) {
      return HexColor(AppColor.colorEmptyRect.hexColor, transparency: 0.50);
    } else if (family.personHealth == PersonHealth.Bad) {
      return AppColor.colorDanger;
    } else {
      return AppColor.colorPrimary;
    }
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
          onTap: onClick,
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
          Center(child: _createCircle()),
          hideName ? Container() : _createText(),
        ],
      ),
    );
  }

  FamilyItem.empty({
    this.family = const Family(fullName: "Kerabat"),
    this.type = FamilyItemType.Empty,
    this.onClick,
    this.hideName = false,
  });

  FamilyItem.add({
    this.family = const Family(fullName: "Tambah"),
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

class FamilyItemList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FamilyItemListState();
  }
}

class FamilyItemListState extends State {
  List<Family> _defaultFamilyList = [
    Family(
      fullName: "Ayah",
      personHealth: PersonHealth.Fine,
      imageUrl:
          "https://blue.kumparan.com/kumpar/image/upload/fl_progressive,fl_lossy,c_fill,q_auto:best,w_640/v1511853177/jedac0gixzhcnuozw7c4.jpg",
    ),
    Family(
      fullName: "Ibu",
      personHealth: PersonHealth.Bad,
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/Suzy_Bae_at_fansigning_on_February_3%2C_2018_%284%29.jpg/220px-Suzy_Bae_at_fansigning_on_February_3%2C_2018_%284%29.jpg",
    ),
    Family(
      fullName: "Kak dinda",
      imageUrl:
          "https://www.sbs.com.au/popasia/sites/sbs.com.au.popasia/files/styles/full/public/twice-tzuyu-7.jpg",
    )
  ];

  List<Family> familyList = [];

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
        FamilyItem.add(
          onClick: () => personClick(1),
        ),
        Container(
          width: Dimen.x12,
        ),
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
      Container(
        width: Dimen.x12,
      ),
    ]);

    return ListView(
      scrollDirection: Axis.horizontal,
      children: content,
    );
  }

  void testSheet2(BuildContext context) {
    createRelieveBottomModal(context, <Widget>[
      Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SpinKitPulse(
            color: HexColor(AppColor.colorPrimary.hexColor, transparency: 0.35),
            size: 300,
            duration: Duration(seconds: 2),
          ),
          SpinKitPulse(
            color: HexColor(AppColor.colorPrimary.hexColor, transparency: 0.65),
            size: 200,
            duration: Duration(seconds: 2),
          ),
          SpinKitPulse(
            size: 110,
            duration: Duration(seconds: 2),
            color: HexColor(AppColor.colorPrimary.hexColor, transparency: 0.9),
          ),
          FamilyItem.normal(
            hideName: true,
            family: Family(
              fullName: "Alif",
              imageUrl:
                  "https://www.sbs.com.au/popasia/sites/sbs.com.au.popasia/files/styles/full/public/twice-tzuyu-7.jpg",
            ),
          ),
        ],
      ),
      Container(height: Dimen.x10),
      StandardButton(
        isHollow: true,
        text: "Menunggu Respons...",
        textColor: AppColor.colorPrimary,
        backgroundColor: AppColor.colorPrimary,
        buttonClick: () => testSheet2(context),
        isCenteredIcon: true,
      ),
    ]);
  }

  void testSheet(BuildContext context) {
    createRelieveBottomModal(context, <Widget>[
      Row(
        children: <Widget>[
          Container(width: Dimen.x12),
          FamilyItem.normal(
            hideName: true,
            family: Family(
              fullName: "Mama",
              imageUrl:
                  "https://www.sbs.com.au/popasia/sites/sbs.com.au.popasia/files/styles/full/public/twice-tzuyu-7.jpg",
            ),
          ),
          Container(width: Dimen.x10),
          Text(
            "Mama",
            style: CircularStdFont.black.getStyle(size: Dimen.x24),
          ),
          Container(width: Dimen.x12),
        ],
      ),
      Container(height: Dimen.x16),
      Row(
        children: <Widget>[
          Container(width: Dimen.x16),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    LocalImage.ic_address_sign.toSvg(width: Dimen.x12),
                    Container(width: Dimen.x4),
                    Text(
                      'Tempat terakhir',
                      style: CircularStdFont.book.getStyle(
                          size: Dimen.x12, color: AppColor.colorTextGrey),
                    )
                  ],
                ),
                Container(height: Dimen.x8),
                Text('Dayeuhkolot, Bandung'),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    LocalImage.ic_clock.toSvg(width: Dimen.x12),
                    Container(width: Dimen.x4),
                    Text(
                      'Kondisi terakhir',
                      style: CircularStdFont.book.getStyle(
                          size: Dimen.x12, color: AppColor.colorTextGrey),
                    )
                  ],
                ),
                Container(height: Dimen.x8),
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimen.x16, vertical: Dimen.x6),
                      decoration: BoxDecoration(
                          color: HexColor(AppColor.colorPrimary.hexColor,
                              transparency: 0.15),
                          borderRadius: BorderRadius.circular(Dimen.x16)),
                      child: Text(
                        'Aman',
                        style: CircularStdFont.bold.getStyle(
                            size: Dimen.x12, color: AppColor.colorPrimary),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: Dimen.x6),
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimen.x8, vertical: Dimen.x6),
                      decoration: BoxDecoration(
                          color: HexColor(AppColor.colorEmptyRect.hexColor,
                              transparency: 0.50),
                          borderRadius: BorderRadius.circular(Dimen.x16)),
                      child: Text(
                        '24h',
                        style: CircularStdFont.bold.getStyle(
                            size: Dimen.x12, color: AppColor.colorTextBlack),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(width: Dimen.x16),
        ],
      ),
      Container(height: Dimen.x16),
      StandardButton(
        text: "PING",
        svgIcon: LocalImage.ic_ping,
        backgroundColor: AppColor.colorPrimary,
        buttonClick: () => testSheet2(context),
        isCenteredIcon: true,
      ),
    ]);
  }

  void personClick(int position) {
    setState(() {
      if (position == 0) {
        familyList.clear();
      } else if (position == 1) {
        familyList = _defaultFamilyList.toList();
      } else if (position == 2) {
        testSheet(context);
      }
    });
  }
}
