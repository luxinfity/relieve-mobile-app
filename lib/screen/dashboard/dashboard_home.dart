import 'package:flutter/material.dart';

import './components/dashboard_user_status.dart';
import '../../widget/item/title.dart';
import '../../res/numbers.dart';

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
