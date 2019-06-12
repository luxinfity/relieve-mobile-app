import 'package:flutter/material.dart';
import 'package:relieve_app/datamodel/disaster.dart';
import 'package:relieve_app/datamodel/location.dart';
import 'package:relieve_app/res/export.dart';
import 'package:relieve_app/service/api/kalomang/kalomang_provider.dart';
import 'package:relieve_app/service/service.dart';
import 'package:relieve_app/widget/common/title.dart';
import 'package:relieve_app/widget/disaster/disaster_item.dart';

class TabDiscoverScreen extends StatefulWidget {
  @override
  _TabDiscoverScreenState createState() => _TabDiscoverScreenState();
}

class _TabDiscoverScreenState extends State<TabDiscoverScreen> {
  List<DisasterDesc> listDisaster = [];

  void loadDisaster() async {
    final disasterResponse =
        await Api.get().setProvider(KalomangProvider()).getDisasterList(1, 5);

    final correctlyParsedData = (disasterResponse.content.data ?? listDisaster);
    correctlyParsedData.removeWhere((obj) => obj == null);

    if (!mounted) return;
    if (disasterResponse?.status == REQUEST_SUCCESS) {
      setState(() {
        listDisaster = correctlyParsedData;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadDisaster();
  }

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
                    location: 'Jawa Timur',
                    time: DateTime.now(),
                    coordinate:
                        Coordinate(37.42796133580664, -122.085749655962),
                  ),
                ),
              ),
              ThemedTitle(
                title: 'Highlight Bencana',
              )
            ]),
          ),
//          SliverGrid(
//            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//              crossAxisCount: 2,
//              crossAxisSpacing: 8,
//              mainAxisSpacing: 8
//            ),
//          ),
          SliverGrid.count(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            children: <Widget>[
              Container(
                color: Colors.amber,
                alignment: Alignment.topRight,
                child: DisasterItem(
                  width: 185,
                  disaster: Disaster(
                    isLive: false,
                    title: 'Gunung Semeru Meletus',
                    location: 'Jawa Timur',
                    time: DateTime.now(),
                    coordinate:
                        Coordinate(37.42796133580664, -122.085749655962),
                  ),
                ),
              ),
              Container(
                color: Colors.red,
                alignment: Alignment.topLeft,
                child: DisasterItem(
                  width: 185,
                  disaster: Disaster(
                    isLive: false,
                    title: 'Gunung Semeru Meletus',
                    location: 'Jawa Timur',
                    time: DateTime.now(),
                    coordinate:
                        Coordinate(37.42796133580664, -122.085749655962),
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
                    location: 'Jawa Timur',
                    time: DateTime.now(),
                    coordinate:
                        Coordinate(37.42796133580664, -122.085749655962),
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
                    location: 'Jawa Timur',
                    time: DateTime.now(),
                    coordinate:
                        Coordinate(37.42796133580664, -122.085749655962),
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
                    location: 'Jawa Timur',
                    time: DateTime.now(),
                    coordinate:
                        Coordinate(37.42796133580664, -122.085749655962),
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
                    location: 'Jawa Timur',
                    time: DateTime.now(),
                    coordinate:
                        Coordinate(37.42796133580664, -122.085749655962),
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
                    location: 'Jawa Timur',
                    time: DateTime.now(),
                    coordinate:
                        Coordinate(37.42796133580664, -122.085749655962),
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
                    location: 'Jawa Timur',
                    time: DateTime.now(),
                    coordinate:
                        Coordinate(37.42796133580664, -122.085749655962),
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
