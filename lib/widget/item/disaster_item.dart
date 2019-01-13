import 'package:flutter/material.dart';

import '../../res/res.dart';
import '../../network/model/disaster.dart';

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
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(Dimen.x8),
            ),
            child: Container(
              color: AppColor.colorDanger,
              height: 144,
              width: 170,
              child: RemoteImage.bg_map
                  .toImage(height: 144, width: 170, fit: BoxFit.cover),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: Dimen.x6,
            ),
            child: Text(disaster.title,
                style: CircularStdFont.bold.getStyle(
                  color: AppColor.colorTextCharcoal,
                  size: Dimen.x14,
                )),
          ),
          RichText(
            text: TextSpan(
              text: disaster.location,
              style: CircularStdFont.medium.getStyle(
                color: AppColor.colorDanger,
                size: Dimen.x10,
              ),
              children: [
                TextSpan(
                  text: ' -${disaster.time} ',
                  style: CircularStdFont.medium.getStyle(
                    color: AppColor.colorEmptyRect,
                    size: Dimen.x10,
                  ),
                )
              ],
            ),
            softWrap: true,
          ),
        ],
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
      // color: Colors.deepPurple,
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
