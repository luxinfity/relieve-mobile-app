import 'package:flutter/material.dart';
import 'package:relieve_app/datamodel/disaster.dart';
import 'package:relieve_app/datamodel/location.dart';
import 'package:relieve_app/res/export.dart';
import 'package:relieve_app/service/firebase/firestore_helper.dart';
import 'package:relieve_app/widget/common/bottom_modal.dart';
import 'package:relieve_app/widget/disaster/disaster_item.dart';

class DisasterItemList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DisasterItemListState();
  }
}

class DisasterItemListState extends State {
  List<DisasterDesc> listDisaster = [];

  void loadDisaster() async {
    final disasters =
        await FirestoreHelper.get().getDisasterList(1, 5, resetMeta: true);

    if (disasters == null || !mounted) return;

    setState(() {
      listDisaster = disasters;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadDisaster();
  }

  Widget _hollowButton() {
    return Material(
      elevation: 1,
      color: Colors.white,
      borderRadius: BorderRadius.circular(Dimen.x4),
      child: InkWell(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          child: LocalImage.icWarning.toSvg(height: 20),
          padding: EdgeInsets.only(
            top: Dimen.x16,
            bottom: Dimen.x16,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimen.x4),
            border: Border.all(color: AppColor.colorDanger, width: 2),
          ),
        ),
      ),
    );
  }

  void testSheet(BuildContext context) {
    RelieveBottomModal.create(context, <Widget>[
      Container(height: 150, color: AppColor.colorEmptyRect),
      Container(height: Dimen.x24),
      Text(
        'Awas!! \nGempa terjadi didekatmu',
        style: CircularStdFont.black.getStyle(size: Dimen.x21),
      ),
      Container(height: Dimen.x36),
      Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: _hollowButton(),
          ),
          Container(width: Dimen.x12),
          Expanded(
            flex: 3,
            child: RaisedButton(
              elevation: 1,
              highlightElevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimen.x4),
              ),
              padding: EdgeInsets.symmetric(vertical: Dimen.x16),
              color: AppColor.colorPrimary,
              textColor: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: LocalImage.icGuard.toSvg(height: 20),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Saya Aman',
                      style: CircularStdFont.bold.getStyle(
                        size: Dimen.x18,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 205,
      padding: EdgeInsets.only(top: Dimen.x12, bottom: Dimen.x4),
      child: ListView.separated(
          separatorBuilder: (bc, idx) => Container(width: Dimen.x8),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: Dimen.x16),
          itemCount: listDisaster.length,
          itemBuilder: (bc, index) => DisasterItem.fixedSize(
                width: 185,
                disaster: Disaster(
                    isLive: false,
                    title: 'Gunung Semeru Meletus',
                    location: 'Jawa Timur',
                    time: DateTime.now(),
                    coordinate:
                        Coordinate(37.42796133580664, -122.085749655962)),
              )),
    );
  }
}
