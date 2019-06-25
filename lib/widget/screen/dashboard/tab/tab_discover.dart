import 'package:flutter/material.dart';
import 'package:relieve_app/datamodel/disaster.dart';
import 'package:relieve_app/datamodel/location.dart';
import 'package:relieve_app/res/export.dart';
import 'package:relieve_app/service/firebase/firestore_helper.dart';
import 'package:relieve_app/widget/common/title.dart';
import 'package:relieve_app/widget/disaster/disaster_item.dart';

class TabDiscoverScreen extends StatefulWidget {
  @override
  _TabDiscoverScreenState createState() => _TabDiscoverScreenState();
}

class _TabDiscoverScreenState extends State<TabDiscoverScreen> {
  Disaster liveEvent;
  List<Disaster> listDisaster = [];

  bool get hasLiveEvent => liveEvent != null;

  void loadDisaster() async {
    final disasters = await FirestoreHelper.get().getDisasterList(1, 5);

    if (disasters == null || !mounted) return;

    setState(() {
      listDisaster = disasters;
    });
  }

  void loadLiveEvent() async {
    final disaster = await FirestoreHelper.get().getLiveEvent();

    if (disaster == null || !mounted) return;

    setState(() {
      liveEvent = disaster;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadLiveEvent();
    loadDisaster();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              Container(height: hasLiveEvent ? Dimen.x28 : 0),
              hasLiveEvent
                  ? Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: Dimen.x16),
                      child: ScreenTitle(title: 'Discover'),
                    )
                  : Container(),
              Container(height: hasLiveEvent ? Dimen.x28 : 0),
              hasLiveEvent
                  ? Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: Dimen.x16),
                      child: DiscoverItem(
                        disaster: Disaster(
                          isLive: true,
                          title: 'Gunung Semeru Meletus',
                          address: 'Jawa Timur',
                          occursAt: DateTime.now(),
                          coordinate:
                              Coordinate(37.42796133580664, -122.085749655962),
                        ),
                      ),
                    )
                  : Container(),
              Container(height: Dimen.x18),
              hasLiveEvent
                  ? ThemedTitle(title: 'Highlight Bencana')
                  : Padding(
                      padding: const EdgeInsets.only(
                        left: Dimen.x16,
                        right: Dimen.x16,
                        bottom: Dimen.x21,
                        top: Dimen.x10,
                      ),
                      child: ScreenTitle(title: 'Highlight Bencana'))
            ]),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: Dimen.x16),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: Dimen.x8,
                crossAxisSpacing: Dimen.x8,
              ),
              delegate: SliverChildBuilderDelegate(
                  (ctx, idx) => DisasterItem.flexible(
                        disaster: Disaster(
                            isLive: false,
                            title: 'Gunung Semeru Meletus',
                            address: 'Jawa Timur',
                            occursAt: DateTime.now(),
                            coordinate: Coordinate(
                                37.42796133580664, -122.085749655962)),
                      ),
                  childCount: listDisaster.length),
            ),
          ),
        ],
      ),
    );
  }
}
