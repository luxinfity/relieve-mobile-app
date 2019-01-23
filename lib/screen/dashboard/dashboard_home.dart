import 'package:flutter/material.dart';

import './components/dashboard_user_status.dart';
import '../../widget/item/title.dart';
import '../../widget/item/family_item.dart';
import '../../widget/item/disaster_item.dart';
import '../../widget/item/weather_item.dart';
import '../../res/res.dart';

class DashboardHomeScreen extends StatelessWidget {
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
                'Cuaca Hari Ini',
                'Selalu siap apapun cuaca nya',
                Dimen.x16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimen.x16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: WeatherItem(
                        weatherType: WeatherType.Rain,
                        classification: 'Hujan Lebat',
                        value: 2.0,
                      ),
                    ),
                    Container(width: Dimen.x4),
                    Expanded(
                      child: WeatherItem(
                        weatherType: WeatherType.Wind,
                        classification: 'Berangin',
                        value: 73,
                      ),
                    ),
                    Container(width: Dimen.x4),
                    Expanded(
                      child: WeatherItem(
                        weatherType: WeatherType.UV,
                        classification: 'Sedang',
                        value: 11,
                      ),
                    ),
                  ],
                ),
              ),
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
