import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:relieve_app/datamodel/family.dart';
import 'package:relieve_app/datamodel/profile.dart';
import 'package:relieve_app/res/res.dart';
import 'package:relieve_app/utils/preference_utils.dart';
import 'package:relieve_app/widget/profile/user_location.dart';

class ProfileBoard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfileBoardState();
}

class ProfileBoardState extends State {
  String locationName;
  Profile profile = PreferenceUtils.get().currentUserProfile;

  void loadPositionName() async {
    var location = 'Kamu belum punya alamat';
//    final addressResponse =
//        await Api.get().setProvider(BakauProvider()).getUserAddress();
//    if (addressResponse?.status == REQUEST_SUCCESS &&
//        addressResponse.content.length > 0) {
//      location = addressResponse.content[0].label;
//    }
    setState(() {
      locationName = location;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadPositionName();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: AppColor.colorPrimary,
          height: 257,
          margin: EdgeInsets.only(bottom: Dimen.x28),
        ),
        Positioned(
          left: 1,
          right: 1,
          bottom: 1,
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: Dimen.x4,
                    color: Colors.white,
                  ),
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: Dimen.x36 + Dimen.x16,
                  backgroundColor: AppColor.colorAccent,
                  backgroundImage: CachedNetworkImageProvider(
                      'https://blue.kumparan.com/kumpar/image/upload/fl_progressive,fl_lossy,c_fill,q_auto:best,w_640/v1511853177/jedac0gixzhcnuozw7c4.jpg'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: Dimen.x16,
                  bottom: Dimen.x21,
                ),
                child: Text(
                  ReCase(profile?.fullName ?? '...').titleCase,
                  style: CircularStdFont.medium.getStyle(
                    size: Dimen.x21,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimen.x21,
                ),
                child: UserLocation(
                  location: locationName == null
                      ? 'Menunggu Lokasi...'
                      : locationName,
                  icon: LocalImage.icMap,
                  personHealth: PersonHealth.None,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
