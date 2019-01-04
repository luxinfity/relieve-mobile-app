import 'package:flutter/material.dart';

import '../dashboard/dashboard.dart';
import '../../res/res.dart';
import '../../res/image.dart';
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
  int _counter = 1;

  void _moveToNext(BuildContext context) {
    if (_counter < WALKTHROUGH_SIZE) {
      setState(() {
        _counter += 1;
      });
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (buikder) => DashboardScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return RelieveScaffold(
      crossAxisAlignment: CrossAxisAlignment.start,
      hasBackButton: true,
      childs: <Widget>[
        Expanded(
          child: buildWalkthroughItem(),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: Dimen.x24),
          child: buildActionButton(context),
        )
      ],
    );
  }

  Container buildWalkthroughItem() {
    return Container(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClipOval(
            clipBehavior: Clip.antiAlias,
            child: Container(
              height: 250,
              width: 250,
              color: AppColor.colorEmptyChip,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Dimen.x16),
            child: buildWalkthroughTitle(),
          ),
          Padding(
            padding: const EdgeInsets.all(Dimen.x16),
            child: buildWalkthroughText(),
          ),
        ],
      )),
      width: double.infinity,
    );
  }

  Text buildWalkthroughTitle() {
    switch (_counter) {
      case 0:
        return Text(
            'Get more aware of a disaster');
      case 1:
        return Text(
            'Make sure they are save ');
      case 2:
        return Text(
            'Help for each other');
      default:
        return Text(
            'All in one Emergency toolkit');      
    }
  }

  Text buildWalkthroughText() {
    switch (_counter) {
      case 0:
        return Text(
            'lorem ipsum sit dolor amet lorem ipsum sit dolor ametlorem ipsum sit dolor ametlorem ipsum sit dolor amet');
      case 1:
        return Text(
            'lorem ipsum sit dolor amet lorem ipsum sit dolor ametlorem ipsum sit dolor ametlorem ipsum sit dolor amet');
      case 2:
        return Text(
            'lorem ipsum sit dolor amet lorem ipsum sit dolor ametlorem ipsum sit dolor ametlorem ipsum sit dolor amet');
      case 3:
        return Text(
            'lorem ipsum sit dolor amet lorem ipsum sit dolor ametlorem ipsum sit dolor ametlorem ipsum sit dolor amet');
      default:
        return Text(
            'Oke Paham Gan');
    }
  }

  StandardButton buildActionButton(BuildContext context) {
    return StandardButton(
      text: (_counter < WALKTHROUGH_SIZE) ? 'Mengerti' : 'Ayo mulai!',
      backgroundColor: AppColor.colorPrimary,
      buttonClick: () => _moveToNext(context),
    );
  }
}
