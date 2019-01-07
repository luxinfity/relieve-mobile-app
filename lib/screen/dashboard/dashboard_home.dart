import 'package:flutter/material.dart';

import './components/dashboard_user_status.dart';

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
        body: Text('alif'),
      ),
    );
    // return NestedScrollView(
    //   headerSliverBuilder: (context, innerBoxIsScrolled) {
    //     return <Widget>[
    //       // Text('akbar', key: Key('ee'),),
    //     ];
    //   },
    //   body: Text('alif', key: Key('11'),),
    // );
    // return Column(
    //   children: <Widget>[
    //     // RelieveTitle(),
    //     // Greeting(name: 'Muh. Alif Akbar'),
    //     UserAppBar(name: 'Muh. Alif Akbar', location: 'Ubud, Bali', isSafe: true),
    //   ],
    // );
  }
}
