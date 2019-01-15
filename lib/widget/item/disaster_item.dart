import 'package:flutter/material.dart';

import '../../res/res.dart';
import '../../network/model/disaster.dart';

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
          child: _buildMap(),
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
            size: Dimen.x11,
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
        LocalImage.ic_live
            .toSvg(height: Dimen.x14, color: AppColor.colorDanger),
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

  ClipRRect _buildMap() {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(Dimen.x8),
      ),
      child: Container(
        color: AppColor.colorDanger,
        height: 220,
        width: double.infinity,
        child: RemoteImage.bg_map2.toImage(fit: BoxFit.cover),
      ),
    );
  }
}

class DisasterItem extends StatelessWidget {
  final Disaster disaster;

  const DisasterItem({
    Key key,
    @required this.disaster,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Dimen.x4,
        right: Dimen.x4,
      ),
      child: Wrap(
        direction: Axis.vertical,
        children: <Widget>[
          _buildMap(),
          _buildTitle(),
          _buildSubtitle(),
        ],
      ),
    );
  }

  RichText _buildSubtitle() {
    return RichText(
      text: TextSpan(
        text: disaster.location,
        style: CircularStdFont.medium.getStyle(
          color: AppColor.colorDanger,
          size: Dimen.x10,
        ),
        children: [
          TextSpan(
            text: ' - ${disaster.time} ',
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

  ClipRRect _buildMap() {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(Dimen.x8),
      ),
      child: Container(
        color: AppColor.colorDanger,
        height: 144,
        width: 180,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            RemoteImage.bg_map.toImage(fit: BoxFit.cover),
            disaster.isLive ? _buildLiveTag() : null,
          ].where((widget) => widget != null).toList(),
        ),
      ),
    );
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
            LocalImage.ic_live.toSvg(
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
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 205,
      width: double.infinity,
      padding: EdgeInsets.only(top: Dimen.x12, bottom: Dimen.x4),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            width: Dimen.x12,
          ),
          DisasterItem(
            disaster: Disaster(
              isLive: true,
              location: "Palembang",
              time: 20000,
              title: "Gempa 7.6 SR",
            ),
          ),
          DisasterItem(
            disaster: Disaster(
              isLive: false,
              location: "Palembang",
              time: 20000,
              title: "Gempa 7.6 SR",
            ),
          ),
          DisasterItem(
            disaster: Disaster(
              isLive: false,
              location: "Palembang",
              time: 20000,
              title: "Gempa 7.6 SR",
            ),
          ),
          DisasterItem(
            disaster: Disaster(
              isLive: false,
              location: "Palembang",
              time: 20000,
              title: "Gempa 7.6 SR",
            ),
          ),
          Container(
            width: Dimen.x12,
          ),
        ],
      ),
    );
  }
}
