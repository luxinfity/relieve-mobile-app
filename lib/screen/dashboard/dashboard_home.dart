import 'package:flutter/material.dart';
// import 'package:dashed_circle/dashed_circle.dart';

import './components/dashboard_user_status.dart';
import '../../widget/item/title.dart';
import '../../widget/item/family_item.dart';
import '../../res/res.dart';

class DashboardHomeScreen extends StatefulWidget {
  DashboardHomeScreen({Key key}) : super(key: key);

  @override
  _DashboardHomeScreenState createState() => _DashboardHomeScreenState();
}

class _DashboardHomeScreenState extends State<DashboardHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NestedScrollView(
        headerSliverBuilder: (builder, isNestedScroll) {
          return <Widget>[
            UserAppBar(
              name: 'Muh. Alif Akbar',
              location: 'Ubud, Bali',
              isSafe: true,
            )
          ];
        },
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: Dimen.x16),
              child: ThemedTitle(
                title: 'Daftar Kerabat',
                subtitle:
                    'Pantau kondisi kerabat terdekat anda dimanapun berada',
              ),
            ),
            Container(
              color: Colors.deepPurple,
              height: 82,
              padding: EdgeInsets.only(top: Dimen.x4, bottom: Dimen.x4),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    width: Dimen.x6,
                  ),
                  FamilyItem(
                    name: 'Alif Akbar',
                    // imageUrl: 'http://cdn2.tstatic.net/kaltim/foto/bank/images/lisa-blackpink_20180723_135959.jpg',
                  ),
                  FamilyItem(
                    name: 'Esa Firman',
                    isFine: false,
                    imageUrl:
                        'http://cdn2.tstatic.net/kaltim/foto/bank/images/lisa-blackpink_20180723_135959.jpg',
                  ),
                  FamilyItem(
                    name: 'kerabat',
                  ),
                  Container(
                    width: Dimen.x6,
                  ),
                  // DashedCircle(
                  //   dashes: 1,
                  //   color: AppColor.colorPrimary,
                  //   child: Padding(
                  //     padding: EdgeInsets.all(Dimen.x4),
                  //     child: CircleAvatar(
                  //       // maxRadius: 28,
                  //       radius: Dimen.x28,
                  //       backgroundImage: NetworkImage(
                  //           'http://cdn2.tstatic.net/kaltim/foto/bank/images/lisa-blackpink_20180723_135959.jpg'),
                  //     ),
                  //   ),
                  //   // dashes: ,
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: Dimen.x16),
              child: ThemedTitle(
                title: 'Discover',
                subtitle:
                    'Update informasi terkini bencana di seluruh Indonesia',
              ),
            )
          ],
        ),
      ),
    );
  }
}
