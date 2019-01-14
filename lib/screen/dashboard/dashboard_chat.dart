import 'package:flutter/material.dart';

import '../../widget/item/title.dart';

class DashboardChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              ScreenTitle(title: 'Chat'),
            ]),
          )
        ],
      ),
    );
  }
}
