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
                        radius: Dimen.x36 + Dimen.x16,
                        backgroundColor: AppColor.colorAccent,
                        backgroundImage: NetworkImage(
                            'https://blue.kumparan.com/kumpar/image/upload/fl_progressive,fl_lossy,c_fill,q_auto:best,w_640/v1511853177/jedac0gixzhcnuozw7c4.jpg'),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimen.x21),
                      child: UserLocation(
                        location: 'Dago Pakar, Bandung',
                        icon: LocalImage.ic_location,
                        personHealth: PersonHealth.None,
                      ),
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
