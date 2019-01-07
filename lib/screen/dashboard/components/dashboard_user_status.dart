import 'package:flutter/material.dart';

import '../../../res/numbers.dart';
import '../../../res/font.dart';
import '../../dashboard/components/dashboard_title.dart';

class Greeting extends StatelessWidget {
  final String name;

  const Greeting({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
          left: Dimen.x16, right: Dimen.x16, top: Dimen.x8, bottom: Dimen.x8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Halo',
            style: CircularStdFont.book.getStyle(size: Dimen.x21),
          ),
          Container(height: Dimen.x4),
          Text(
            name,
            style: CircularStdFont.black.getStyle(size: Dimen.x21),
          )
        ],
      ),
    );
  }
}

class UserAppBar extends StatelessWidget {
  final String name;
  final String location;
  final bool isSafe;

  const UserAppBar({
    Key key,
    this.name,
    this.location,
    this.isSafe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return AppBar(
    //   title: Text('Alof'),
    // );
    // return SliverAppBar();
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      title: RelieveTitle(style: RelieveTitleStyle.light,),
      
      flexibleSpace: FlexibleSpaceBar(
          // centerTitle: true,
          // title: Text("Collapsing Toolbar",
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontSize: 16.0,
          //     )),
          // collapseMode: CollapseMode.parallax,
          background: Image.network(
        "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
        fit: BoxFit.cover,
      )),
    );
  }
}
