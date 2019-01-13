import 'package:flutter/material.dart';

import './components/dashboard_user_status.dart';
import '../../network/model/family.dart';
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
      child: CustomScrollView(
        slivers: <Widget>[
          UserAppBar(
            name: 'Muh. Alif Akbar',
            location: 'Ubud, Bali',
            isSafe: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              _createTitle(
                'Daftar Kerabat',
                'Pantau kondisi kerabat terdekat anda dimanapun berada',
                Dimen.x16,
              ),
              FamilyItemList(),
              _createTitle(
                'Discover',
                'Update informasi terkini bencana di seluruh Indonesia',
                0,
              ),
              _createDiscoverList()
            ]),
          )
        ],
      ),
    );
  }

  Widget _createTitle(String title, String subtitle, double paddingTop) {
    return Padding(
      padding: EdgeInsets.only(top: paddingTop),
      child: ThemedTitle(
        title: title,
        subtitle: subtitle,
      ),
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
