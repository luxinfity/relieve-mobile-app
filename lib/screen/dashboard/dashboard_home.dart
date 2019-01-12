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
            _createFamilyList(),
            Padding(
              padding: const EdgeInsets.only(top: Dimen.x16),
              child: ThemedTitle(
                title: 'Discover',
                subtitle:
                    'Update informasi terkini bencana di seluruh Indonesia',
              ),
            ),
            _createDiscoverList()
          ],
        ),
      ),
    );
  }

  Widget _createFamilyList() {
    return Container(
      color: Colors.deepPurple,
      height: 84,
      width: double.infinity,
      padding: EdgeInsets.only(top: Dimen.x4, bottom: Dimen.x4),
      child: Text('Alif'),
    );
  }

  Widget _createDiscoverList() {
    return Container(
      color: Colors.deepPurple,
      height: 180,
      width: double.infinity,
      padding: EdgeInsets.only(top: Dimen.x12, bottom: Dimen.x4),
      child: Text('Alif'),
    );
  }
}
