import 'package:flutter/material.dart';

import '../../widget/item/relieve_title.dart';

class DashboardHomeScreen extends StatefulWidget {
  DashboardHomeScreen({Key key}) : super(key: key);

  @override
  _DashboardHomeScreenState createState() => _DashboardHomeScreenState();
}

class _DashboardHomeScreenState extends State<DashboardHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RelieveTitle()
      ],
    );
  }
}
