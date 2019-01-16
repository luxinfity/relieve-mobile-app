import 'package:flutter/material.dart';

import '../../res/res.dart';
import '../../network/model/family.dart';
import '../../widget/item/user_location.dart';

class DashboardProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          Stack(
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
                        minRadius: Dimen.x36 + Dimen.x16,
                        backgroundColor: AppColor.colorAccent,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: Dimen.x16,
                        bottom: Dimen.x21,
                      ),
                      child: Text(
                        'Muhammad Alif Akbar',
                        style: CircularStdFont.medium.getStyle(
                          size: Dimen.x21,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    UserLocation(
                      location: 'Dago Pakar, Bandung',
                      icon: LocalImage.ic_location,
                      personHealth: PersonHealth.None,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text('Alif'),
        ],
      ),
    );
  }
}
// 257 + 26
