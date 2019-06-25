import 'package:flutter/material.dart';
import 'package:relieve_app/datamodel/disaster.dart';
import 'package:relieve_app/datamodel/map_data.dart';
import 'package:relieve_app/res/export.dart';
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
          disaster.address,
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

  const DisasterItem._({
    Key key,
    @required this.disaster,
    this.width,
  }) : super(key: key);

  const DisasterItem.fixedSize({
    Key key,
    @required this.disaster,
    this.width = 180,
  }) : super(key: key);

  const DisasterItem.flexible({
    Key key,
    @required this.disaster,
    this.width = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(Dimen.x6),
      onTap: () {},
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildItem(context),
            _buildTitle(),
            _buildSubtitle()
          ]),
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
    final timeDiff = DateTime.now().difference(disaster.occursAt);
    return RichText(
      text: TextSpan(
        text: disaster.address,
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
        width: width > 0 ? width : null,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            _buildMap(),
            _buildRedDot(),
            disaster.isLive ? _buildLiveTag() : Container(),
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
