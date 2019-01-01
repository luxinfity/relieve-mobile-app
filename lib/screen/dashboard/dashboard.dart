import 'package:flutter/material.dart';
import 'components/dashboard_bottom_bar.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      bottomNavigationBar: RelieveBottomNavigationBar(),
      body: Center(
        child: Text('This is dashboard'),
      ),
    );
  }
}
