import 'package:flutter/material.dart';

import '../../res/res.dart';
import '../../widget/item/title.dart';
import '../../widget/item/disaster_item.dart';
import '../../service/model/disaster.dart';

class DashboardDiscoverScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: Dimen.x16,
                  top: Dimen.x24,
                  bottom: Dimen.x12,
                ),
                child: ScreenTitle(title: 'Discover'),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: Dimen.x16,
                  right: Dimen.x16,
                  top: Dimen.x12,
                  bottom: Dimen.x24,
                ),
                child: DiscoverItem(
                  disaster: Disaster(
                    isLive: true,
                    title: 'Gunung Semeru Meletus',
                    location: 'Probolinggo, Jawa Timur',
                    time: 400,
                  ),
                ),
              ),
              ThemedTitle(
                title: 'Highlight Bencana',
              )
            ]),
          ),
          SliverGrid.count(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            children: <Widget>[
              Container(
                alignment: Alignment.topRight,
                child: DisasterItem(
                  width: 185,
                  disaster: Disaster(
                    isLive: false,
                    title: 'Gunung Semeru Meletus',
                    location: 'Probolinggo, Jawa Timur',
                    time: 400,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: DisasterItem(
                  width: 185,
                  disaster: Disaster(
                    isLive: false,
                    title: 'Gunung Semeru Meletus',
                    location: 'Probolinggo, Jawa Timur',
                    time: 400,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                child: DisasterItem(
                  width: 185,
                  disaster: Disaster(
                    isLive: false,
                    title: 'Gunung Semeru Meletus',
                    location: 'Probolinggo, Jawa Timur',
                    time: 400,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: DisasterItem(
                  width: 185,
                  disaster: Disaster(
                    isLive: false,
                    title: 'Gunung Semeru Meletus',
                    location: 'Probolinggo, Jawa Timur',
                    time: 400,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                child: DisasterItem(
                  width: 185,
                  disaster: Disaster(
                    isLive: false,
                    title: 'Gunung Semeru Meletus',
                    location: 'Probolinggo, Jawa Timur',
                    time: 400,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: DisasterItem(
                  width: 185,
                  disaster: Disaster(
                    isLive: false,
                    title: 'Gunung Semeru Meletus',
                    location: 'Probolinggo, Jawa Timur',
                    time: 400,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                child: DisasterItem(
                  width: 185,
                  disaster: Disaster(
                    isLive: false,
                    title: 'Gunung Semeru Meletus',
                    location: 'Probolinggo, Jawa Timur',
                    time: 400,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: DisasterItem(
                  width: 185,
                  disaster: Disaster(
                    isLive: false,
                    title: 'Gunung Semeru Meletus',
                    location: 'Probolinggo, Jawa Timur',
                    time: 400,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
