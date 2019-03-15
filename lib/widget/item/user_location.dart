import 'package:flutter/material.dart';
import 'package:relieve_app/res/res.dart';
import 'package:relieve_app/service/model/family.dart';

class UserLocation extends StatelessWidget {
  final String location;
  final PersonHealth personHealth;
  final LocalImage icon;

  const UserLocation({
    Key key,
    @required this.location,
    @required this.personHealth,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color tint = AppColor.colorTextBlack;
    if (personHealth == PersonHealth.Fine) {
      tint = AppColor.colorPrimary;
    } else if (personHealth == PersonHealth.Bad) {
      tint = AppColor.colorDanger;
    }

    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: Dimen.x16,
        vertical: Dimen.x6,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: Dimen.x18,
              bottom: Dimen.x18,
              left: Dimen.x21,
              right: Dimen.x12,
            ),
            child: icon.toSvg(
              height: Dimen.x16,
              width: Dimen.x21,
              color: tint,
            ),
          ),
          Text(
            location,
            style: CircularStdFont.medium.getStyle(
              size: Dimen.x16,
              color: tint,
            ),
          ),
        ],
      ),
    );
  }
}
