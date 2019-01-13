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
  List<Family> familyList = [
    Family(fullName: 'Ayah'),
    Family(fullName: 'Ibu'),
    Family(fullName: 'Kak dinda'),
  ]; // empty list

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
            FamilyItemList(familyList: familyList),
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
