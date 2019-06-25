import 'package:flutter/material.dart';
import 'package:relieve_app/res/export.dart';
import 'package:relieve_app/widget/common/title.dart';
import 'package:relieve_app/widget/disaster/disaster_list.dart';
import 'package:relieve_app/widget/family/family_list.dart';
import 'package:relieve_app/widget/screen/dashboard/components/user_app_bar.dart';
import 'package:relieve_app/widget/weather/weather_item.dart';

class TabHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(
        slivers: <Widget>[
          UserAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              _createTitle(
                'Cuaca Hari Ini',
                'Selalu siap apapun cuaca nya',
                Dimen.x16,
              ),
              WeatherItemList(),
              _createTitle(
                'Daftar Kerabat',
                'Pantau kondisi kerabat terdekat anda dimanapun berada',
                Dimen.x16,
              ),
              FamilyItemList(),
              _createTitle(
                'Discover',
                'Update informasi terkini bencana di seluruh Indonesia',
                Dimen.x16,
              ),
              DisasterItemList()
            ]),
          )
        ],
      ),
    );
  }

  Widget _createTitle(
    String title,
    String subtitle,
    double paddingTop,
  ) {
    return Padding(
      padding: EdgeInsets.only(top: paddingTop),
      child: ThemedTitle(
        title: title,
        subtitle: subtitle,
      ),
    );
  }
}
