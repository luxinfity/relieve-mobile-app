import 'package:flutter/material.dart';

import '../dashboard/dashboard.dart';
import '../../res/res.dart';
// import '../../res/image.dart';
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

  final PageController _controller = PageController();

  void _moveToNext(BuildContext context) {
    if (_counter < WALKTHROUGH_SIZE - 1) {
      _controller.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (buikder) => DashboardScreen()));
    }
  }

  void onPageChanged(int page) {
    if (_counter < WALKTHROUGH_SIZE) {
      setState(() {
        _counter = page;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    return RelieveScaffold(
      crossAxisAlignment: CrossAxisAlignment.start,
      // hasBackButton: true,
      childs: <Widget>[
        Expanded(
          child: PageView(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            onPageChanged: onPageChanged,
            children: <Widget>[
              buildWalkthroughItem(0),
              buildWalkthroughItem(1),
              buildWalkthroughItem(2),
              buildWalkthroughItem(3),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: Dimen.x16 + padding.bottom),
          child: buildActionButton(context),
        )
      ],
    );
  }

  Container buildWalkthroughItem(int position) {
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
            child: buildWalkthroughTitle(position),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: Dimen.x28, right: Dimen.x28),
            child: buildWalkthroughText(position),
          ),
        ],
      )),
      width: double.infinity,
    );
  }

  Text buildWalkthroughTitle(int position) {
    switch (position) {
      case 0:
        return Text(
          'Get more aware of a disaster',
          style: CircularStdFont.getFont(style: CircularStdFontStyle.Bold, size: Dimen.x18),
        );
      case 1:
        return Text('Make sure they are save',
          style: CircularStdFont.getFont(style: CircularStdFontStyle.Bold, size: Dimen.x18),
        );
      case 2:
        return Text('Help for each other',
          style: CircularStdFont.getFont(style: CircularStdFontStyle.Bold, size: Dimen.x18),
        );
      default:
        return Text('All in one Emergency toolkit',
          style: CircularStdFont.getFont(style: CircularStdFontStyle.Bold, size: Dimen.x18),
        );
    }
  }

  Text buildWalkthroughText(int position) {
    switch (position) {
      case 0:
        return Text(
            'lorem ipsum sit dolor amet lorem ipsum sit dolor ametlorem ipsum sit dolor ametlorem ipsum sit dolor amet',
            textAlign: TextAlign.center);
      case 1:
        return Text(
            'lorem ipsum sit dolor amet lorem ipsum sit dolor ametlorem ipsum sit dolor ametlorem ipsum sit dolor amet',
            textAlign: TextAlign.center);
      case 2:
        return Text(
            'lorem ipsum sit dolor amet lorem ipsum sit dolor ametlorem ipsum sit dolor ametlorem ipsum sit dolor amet',
            textAlign: TextAlign.center);
      default:
        return Text('Oke Paham Gan', textAlign: TextAlign.center);
    }
  }

  StandardButton buildActionButton(BuildContext context) {
    return StandardButton(
      text: (_counter < WALKTHROUGH_SIZE - 1) ? 'Mengerti' : 'Ayo mulai!',
      backgroundColor: AppColor.colorPrimary,
      buttonClick: () => _moveToNext(context),
    );
  }
}
