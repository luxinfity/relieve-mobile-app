import 'package:flutter/material.dart';

import '../../widget/item/screen_title.dart';

class DashboardProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              ScreenTitle(title: 'Profile'),
            ]),
          )
        ],
      ),
    );
  }
}
