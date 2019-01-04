import 'package:flutter/material.dart';

import '../dashboard/dashboard.dart';
import '../../res/color.dart';
import '../../widget/relieve_scaffold.dart';
import '../../widget/item/standard_button.dart';

class WalkthroughScreen extends StatefulWidget {
  WalkthroughScreen({Key key}) : super(key: key);

  @override
  _WalkthroughScreenState createState() => _WalkthroughScreenState();
}

const WALKTHROUGH_SIZE = 4;

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  int _counter = 0;

  void _moveToNext(BuildContext context) {
    if (_counter < WALKTHROUGH_SIZE) {
      setState(() {
        _counter += 1;
      });
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (buikder) => DashboardScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return RelieveScaffold(
      crossAxisAlignment: CrossAxisAlignment.start,
      hasBackButton: true,
      childs: <Widget>[
        Text(_counter.toString()),
        buildActionButton(context)
      ],
    );
  }

  StandardButton buildActionButton(BuildContext context) {
    return StandardButton(
        text: (_counter < WALKTHROUGH_SIZE) ? 'Mengerti' : 'Ayo mulai!',      
        backgroundColor: AppColor.colorPrimary,
        buttonClick: () => _moveToNext(context),
      );
  }
}
