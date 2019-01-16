import 'package:flutter/material.dart';

import '../../widget/item/title.dart';
import '../../res/res.dart';

class DashboardChatScreen extends StatelessWidget {
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
                child: ScreenTitle(title: 'Chat'),
              ),
            ]),
          ),
          SliverFillRemaining(
            child: Container(
              child: Text('Alif'),
              color: AppColor.colorAccent,
            ),
          )
        ],
      ),
    );
  }
}
