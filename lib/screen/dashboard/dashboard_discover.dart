import 'package:flutter/material.dart';

import '../../res/res.dart';

class DashboardDiscoverScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              Text('Discover',
                  style: CircularStdFont.black.getStyle(size: Dimen.x21)),
            ]),
          )
          // Text('This is discover'),
        ],
      ),
    );
  }
}
