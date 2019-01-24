import 'package:flutter/material.dart';

import '../../../res/res.dart';
import '../../../service/model/family.dart';
import '../../dashboard/components/dashboard_title.dart';
import '../../../widget/item/user_location.dart';

class Greeting extends StatelessWidget {
  final String name;

  const Greeting({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
          left: Dimen.x16, right: Dimen.x16, top: Dimen.x8, bottom: Dimen.x8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Halo',
            style: CircularStdFont.book
                .getStyle(size: Dimen.x24)
                .apply(color: Colors.white),
          ),
          Container(height: Dimen.x4),
          Text(
            name,
            style: CircularStdFont.black
                .getStyle(size: Dimen.x24)
                .apply(color: Colors.white),
          )
        ],
      ),
    );
  }
}

class UserAppBar extends StatelessWidget {
  final String name;
  final String location;
  final bool isSafe;

  const UserAppBar({
    Key key,
    this.name,
    this.location,
    this.isSafe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250,
      floating: false,
      pinned: true,
      centerTitle: false,
      title: RelieveTitle(
        style: RelieveTitleStyle.light,
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: <Widget>[
            buildBgImage(),
            buildBlueLayer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Greeting(name: name),
                Padding(
                  padding: EdgeInsets.only(top: Dimen.x24, bottom: Dimen.x18),
                  child: UserLocation(
                    location: location,
                    icon: LocalImage.ic_live,
                    personHealth: PersonHealth.Fine,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Container buildBlueLayer() {
    return Container(
      color: HexColor(
        AppColor.colorPrimary.hexColor,
        transparancy: 0.65,
      ),
    );
  }

  Container buildBgImage() {
    return Container(
      width: double.infinity,
      child: RemoteImage.bg_bali.toImage(
        fit: BoxFit.cover,
      ),
    );
  }
}
