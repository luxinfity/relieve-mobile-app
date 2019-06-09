import 'package:flutter/material.dart';
import 'package:relieve_app/widget/common/relieve_scaffold.dart';
import 'package:relieve_app/widget/screen/call/call.dart';
import 'package:relieve_app/widget/screen/dashboard/components/dashboard_bottom_bar.dart';
import 'package:relieve_app/widget/screen/dashboard/dashboard_chat.dart';
import 'package:relieve_app/widget/screen/dashboard/dashboard_discover.dart';
import 'package:relieve_app/widget/screen/dashboard/dashboard_home.dart';
import 'package:relieve_app/widget/screen/dashboard/dashboard_profile.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;

  void _goToCall(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (builder) => CallScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return RelieveScaffold(
      hasAppBarScreen: currentIndex == 0, // only first screen has app bar
      bottomNavigationBar: RelieveBottomNavigationBar(onPress: (index, isCall) {
        if (isCall) {
          _goToCall(context);
        } else {
          setState(() {
            currentIndex = index;
          });
        }
      }),
      childs: <Widget>[
        buildBody(),
      ],
    );
  }

  Widget buildBody() {
    switch (currentIndex) {
      case 0:
        return DashboardHomeScreen();
      case 1:
        return DashboardDiscoverScreen();
      case 3:
        return DashboardChatScreen();
      case 4:
        return DashboardProfileScreen();
      default:
        return Text('Dashboard');
    }
  }
}
