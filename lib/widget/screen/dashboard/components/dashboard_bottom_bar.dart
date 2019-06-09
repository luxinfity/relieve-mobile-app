import 'package:flutter/material.dart';
import 'package:relieve_app/res/res.dart';
import 'package:relieve_app/utils/relieve_callback.dart';

class RelieveBottomNavigationBar extends StatefulWidget {
  RelieveBottomNavigationBar({this.onPress});

  final RelieveBottomAction onPress;

  @override
  RelieveBottomNavigationBarState createState() {
    return new RelieveBottomNavigationBarState();
  }
}

class RelieveBottomNavigationBarState
    extends State<RelieveBottomNavigationBar> {
  int currentIndex = 0;

  static const CALL_INDEX = 3;

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    return Container(
        padding: EdgeInsets.only(bottom: padding.bottom),
        color: Colors.white,
        child: Wrap(
          children: <Widget>[
            Column(
              children: <Widget>[
                Divider(height: 0.5),
                Container(height: 56, color: Colors.white, child: buildRow()),
              ],
            ),
          ],
        ));
  }

  Widget buildItem(int index, LocalImage icon, String text) {
    final isActive = currentIndex == index;
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            this.setState(() {
              currentIndex = index;
            });
            if (widget.onPress != null) {
              widget.onPress(index, false);
            }
          },
          child: buildIconItem(icon, isActive, text),
        ),
      ),
    );
  }

  Container buildIconItem(LocalImage icon, bool isActive, String text) {
    return Container(
      width: 56,
      height: 56,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 20,
            height: 20,
            margin: EdgeInsets.only(bottom: 4),
            child: icon.toSvg(color: isActive ? Colors.blue : Colors.grey),
          ),
          isActive
              ? Text(text, style: TextStyle(fontSize: 10, color: Colors.blue))
              : null
        ].where((o) => o != null).toList(),
      ),
    );
  }

  Widget buildCallWidget() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Material(
        color: Colors.blue,
        child: InkWell(
            onTap: () {
              if (widget.onPress != null) {
                widget.onPress(CALL_INDEX, true);
              }
            },
            child: Padding(
              child: LocalImage.ic_call.toSvg(width: 20, height: 20),
              padding: EdgeInsets.all(14),
            )),
      ),
    );
  }

  Row buildRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        buildItem(0, LocalImage.ic_home, 'Home'),
        buildItem(1, LocalImage.ic_discover, 'Discover'),
        buildCallWidget(),
        buildItem(3, LocalImage.ic_chat, 'Chat'),
        buildItem(4, LocalImage.ic_user, 'Profile')
      ],
    );
  }
}
