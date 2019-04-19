import "package:flutter/material.dart";
import "package:relieve_app/widget/inherited/app_config.dart";
import "package:relieve_app/res/res.dart";
import "package:relieve_app/service/model/disaster.dart";
import 'package:relieve_app/service/model/location.dart';
import "package:relieve_app/service/service.dart";
import "package:relieve_app/widget/disaster/disaster_item.dart";
import "package:relieve_app/widget/common/title.dart";

class DashboardDiscoverScreen extends StatefulWidget {
  @override
  _DashboardDiscoverScreenState createState() =>
      _DashboardDiscoverScreenState();
}

class _DashboardDiscoverScreenState extends State<DashboardDiscoverScreen> {
  List<DisasterDesc> listDisaster = [];

  void loadDisaster() async {
    final disasterResponse =
        await KalomangApi(AppConfig.of(context)).getDisasterList(1, 5);
    if (disasterResponse?.status == REQUEST_SUCCESS) {
      setState(() {
        listDisaster = disasterResponse.content.data;
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
                child: ScreenTitle(title: "Discover"),
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
                    title: "Gunung Semeru Meletus",
                    location: "Jawa Timur",
                    time: DateTime.now(),
                    coordinate: Location(37.42796133580664, -122.085749655962),
                  ),
                ),
              ),
              ThemedTitle(
                title: "Highlight Bencana",
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
                    title: "Gunung Semeru Meletus",
                    location: "Jawa Timur",
                    time: DateTime.now(),
                    coordinate: Location(37.42796133580664, -122.085749655962),
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
                    title: "Gunung Semeru Meletus",
                    location: "Jawa Timur",
                    time: DateTime.now(),
                    coordinate: Location(37.42796133580664, -122.085749655962),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                child: DisasterItem(
                  width: 185,
                  disaster: Disaster(
                    isLive: false,
                    title: "Gunung Semeru Meletus",
                    location: "Jawa Timur",
                    time: DateTime.now(),
                    coordinate: Location(37.42796133580664, -122.085749655962),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: DisasterItem(
                  width: 185,
                  disaster: Disaster(
                    isLive: false,
                    title: "Gunung Semeru Meletus",
                    location: "Jawa Timur",
                    time: DateTime.now(),
                    coordinate: Location(37.42796133580664, -122.085749655962),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                child: DisasterItem(
                  width: 185,
                  disaster: Disaster(
                    isLive: false,
                    title: "Gunung Semeru Meletus",
                    location: "Jawa Timur",
                    time: DateTime.now(),
                    coordinate: Location(37.42796133580664, -122.085749655962),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: DisasterItem(
                  width: 185,
                  disaster: Disaster(
                    isLive: false,
                    title: "Gunung Semeru Meletus",
                    location: "Jawa Timur",
                    time: DateTime.now(),
                    coordinate: Location(37.42796133580664, -122.085749655962),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                child: DisasterItem(
                  width: 185,
                  disaster: Disaster(
                    isLive: false,
                    title: "Gunung Semeru Meletus",
                    location: "Jawa Timur",
                    time: DateTime.now(),
                    coordinate: Location(37.42796133580664, -122.085749655962),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: DisasterItem(
                  width: 185,
                  disaster: Disaster(
                    isLive: false,
                    title: "Gunung Semeru Meletus",
                    location: "Jawa Timur",
                    time: DateTime.now(),
                    coordinate: Location(37.42796133580664, -122.085749655962),
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
