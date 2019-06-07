import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:relieve_app/datamodel/family.dart';
import 'package:relieve_app/datamodel/location.dart';
import 'package:relieve_app/datamodel/user.dart';
import 'package:relieve_app/res/res.dart';
import 'package:relieve_app/service/api/base.dart';
import 'package:relieve_app/service/service.dart';
import 'package:relieve_app/widget/profile/user_location.dart';
import 'package:relieve_app/widget/screen/dashboard/components/dashboard_title.dart';

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

class UserAppBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserAppBarState();
}

class UserAppBarState extends State {
  IndonesiaPlace indonesiaPlace;
  bool isSafe = false;

  User user = User(fullName: '');

  void loadUser() async {
    final userResponse = await Api.get().setProvider(BakauProvider()).getUser();
    if (userResponse?.status == REQUEST_SUCCESS) {
      setState(() {
        user = userResponse.content;
      });
    }
  }

  void loadPositionName() async {
    if (!await LocationService.isLocationRequestPermitted()) {
      LocationService.showAskPermissionModal(context, () {
        loadPositionName();
      });
      return;
    }

    final place = await LocationService.getLastKnownPlaceDetail(context);
    if (place != null) {
      setState(() {
        indonesiaPlace = place;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadUser();
    loadPositionName();
  }

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
            Positioned.fill(
              child: buildBgImage(),
            ),
            buildBlueLayer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Greeting(name: ReCase(user.fullName).titleCase),
                Padding(
                  padding: EdgeInsets.only(top: Dimen.x24, bottom: Dimen.x18),
                  child: UserLocation(
                    location: indonesiaPlace == null
                        ? 'Menunggu Lokasi...'
                        : '${indonesiaPlace.city}, ${indonesiaPlace.province}',
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
        transparency: 0.65,
      ),
    );
  }

  Container buildBgImage() {
    return Container(
        child: indonesiaPlace == null
            ? RemoteImage.bg_dki_jakarta.toImage(fit: BoxFit.cover)
            : BackgroundImage(indonesiaPlace.province)
                .toImage(fit: BoxFit.cover));
  }
}
