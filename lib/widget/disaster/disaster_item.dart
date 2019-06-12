import 'package:flutter/material.dart';
import 'package:relieve_app/datamodel/disaster.dart';
import 'package:relieve_app/datamodel/map_data.dart';
import 'package:relieve_app/res/export.dart';
import 'package:relieve_app/service/api/kalomang/kalomang_provider.dart';
import 'package:relieve_app/service/service.dart';
import 'package:relieve_app/widget/common/bottom_modal.dart';
import 'package:relieve_app/widget/map/static_map.dart';

class DiscoverItem extends StatelessWidget {
  final Disaster disaster;

  const DiscoverItem({
    Key key,
    this.disaster,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildLiveTitle(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimen.x10),
          child: _buildItem(context),
        ),
        Text(
          disaster.title,
          style: CircularStdFont.black.getStyle(
            color: AppColor.colorTextBlack,
            size: Dimen.x18,
          ),
        ),
        Text(
          disaster.location,
          style: CircularStdFont.book.getStyle(
            color: AppColor.colorTextBlack,
            size: Dimen.x12,
          ),
        ),
      ],
    );
  }

  Wrap _buildLiveTitle() {
    return Wrap(
      direction: Axis.horizontal,
      spacing: Dimen.x8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        LocalImage.icLive.toSvg(height: Dimen.x14, color: AppColor.colorDanger),
        Text(
          'Sekarang!',
          style: CircularStdFont.black.getStyle(
            size: Dimen.x18,
            color: AppColor.colorDanger,
          ),
        )
      ],
    );
  }

  Widget _buildItem(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(Dimen.x8)),
      child: Container(
        color: AppColor.colorEmptyRect,
        height: 220,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          overflow: Overflow.clip,
          children: <Widget>[
            _buildMap(),
            _buildRedDot(),
            Container(color: Colors.transparent)
          ],
        ),
      ),
    );
  }

  Widget _buildRedDot() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.colorDanger,
          shape: BoxShape.circle,
        ),
        width: Dimen.x8,
      ),
    );
  }

  Widget _buildMap() {
    return StaticMap(MapData(
      disaster.coordinate,
      300,
      220,
    ));
  }
}

class DisasterItem extends StatelessWidget {
  final Disaster disaster;
  final double width;
  final VoidCallback onClick;

  const DisasterItem({
    Key key,
    @required this.disaster,
    this.width = 180,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(Dimen.x6),
      onTap: onClick,
      child: Padding(
        padding: EdgeInsets.only(
          left: Dimen.x4,
          right: Dimen.x4,
        ),
        child: Wrap(
          direction: Axis.vertical,
          children: <Widget>[
            _buildItem(context),
            _buildTitle(),
            _buildSubtitle(),
          ],
        ),
      ),
    );
  }

  String _getDescBasedOnTime(Duration diff) {
    if (diff.inDays > 0) {
      return '${diff.inDays} hari yang lalu';
    } else if (diff.inHours > 0) {
      return '${diff.inHours} jam yang lalu';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes} menit yang lalu';
    } else {
      return '${diff.inSeconds} detik yang lalu';
    }
  }

  RichText _buildSubtitle() {
    final timeDiff = DateTime.now().difference(disaster.time);
    return RichText(
      text: TextSpan(
        text: disaster.location,
        style: CircularStdFont.medium.getStyle(
          color: AppColor.colorDanger,
          size: Dimen.x10,
        ),
        children: [
          TextSpan(
            text: ' - ${_getDescBasedOnTime(timeDiff)}',
            style: CircularStdFont.medium.getStyle(
              color: AppColor.colorEmptyRect,
              size: Dimen.x10,
            ),
          )
        ],
      ),
      softWrap: true,
    );
  }

  Padding _buildTitle() {
    return Padding(
      padding: EdgeInsets.only(
        top: Dimen.x6,
      ),
      child: Text(disaster.title,
          style: CircularStdFont.bold.getStyle(
            color: AppColor.colorTextCharcoal,
            size: Dimen.x14,
          )),
    );
  }

  Widget _buildItem(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(Dimen.x8)),
      child: Container(
        color: AppColor.colorEmptyRect,
        height: 144,
        width: width,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            _buildMap(),
            _buildRedDot(),
            disaster.isLive ? _buildLiveTag() : null,
            Container(color: Colors.transparent)
          ].where((widget) => widget != null).toList(),
        ),
      ),
    );
  }

  Widget _buildRedDot() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.colorDanger,
          shape: BoxShape.circle,
        ),
        width: Dimen.x8,
      ),
    );
  }

  Widget _buildMap() {
    return StaticMap(MapData(
      disaster.coordinate,
      width.toInt() + 1,
      144,
    ));
  }

  Widget _buildLiveTag() {
    return Positioned(
      top: Dimen.x12,
      left: Dimen.x12,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimen.x6),
          color: AppColor.colorDanger,
        ),
        padding: EdgeInsets.symmetric(horizontal: Dimen.x8, vertical: Dimen.x6),
        child: Wrap(
          spacing: Dimen.x6,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            LocalImage.icLive.toSvg(
              height: Dimen.x10,
              width: Dimen.x12,
              color: Colors.white,
            ),
            Text(
              'Live',
              style: CircularStdFont.medium
                  .getStyle(size: Dimen.x12, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class DisasterItemList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DisasterItemListState();
  }
}

class DisasterItemListState extends State {
  List<DisasterDesc> listDisaster = [];

  void loadDisaster() async {
    final disasterResponse =
        await Api.get().setProvider(KalomangProvider()).getDisasterList(1, 5);

    final correctlyParsedData = (disasterResponse.content.data ?? listDisaster);
    correctlyParsedData.removeWhere((obj) => obj == null);

    if (disasterResponse?.status == REQUEST_SUCCESS) {
      if (!mounted) return;
      setState(() {
        listDisaster = correctlyParsedData;
      });
    }
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
      width: double.infinity,
      padding: EdgeInsets.only(top: Dimen.x12, bottom: Dimen.x4),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (bc, index) {
          return Container(
            padding: EdgeInsets.only(
                left: index == 0 ? 8.0 : 0.0,
                right: index == listDisaster.length - 1 ? 8.0 : 0.0),
            child: DisasterItem(
                disaster: Disaster(
                    isLive: false,
                    location: 'Palembang',
                    time: listDisaster[index].occursAt,
                    title: 'Gempa ${listDisaster[index].magnitude} SR',
                    coordinate: listDisaster[index].coordinate),
                onClick: () {
                  testSheet(context);
                }),
          );
        },
        itemCount: listDisaster.length,
      ),
    );
  }
}
