import "package:flutter/material.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:relieve_app/app_config.dart";
import "package:relieve_app/res/res.dart";
import "package:recase/recase.dart";
import "package:relieve_app/service/model/user.dart";
import "package:relieve_app/service/source/api/api.dart";
import "package:relieve_app/service/model/family.dart";
import "package:relieve_app/widget/item/user_location.dart";

class ProfileBoard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfileBoardState();
}

class ProfileBoardState extends State {
  User user = User(fullname: "");

  void loadUser() async {
    final userResponse = await BakauApi(AppConfig.of(context)).getUser();
    if (userResponse?.status == REQUEST_SUCCESS) {
      setState(() {
        user = userResponse.content;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadUser();
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
                      "https://blue.kumparan.com/kumpar/image/upload/fl_progressive,fl_lossy,c_fill,q_auto:best,w_640/v1511853177/jedac0gixzhcnuozw7c4.jpg"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: Dimen.x16,
                  bottom: Dimen.x21,
                ),
                child: Text(
                  ReCase(user.fullname).titleCase,
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
                  location: "Sukajadi, Bandung",
                  icon: LocalImage.ic_location,
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
