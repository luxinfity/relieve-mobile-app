import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../res/res.dart';
import '../utils/common_utils.dart';

class RelieveScaffold extends StatelessWidget {
  final List<Widget> childs;
  final CrossAxisAlignment crossAxisAlignment;
  final bool hasBackButton;
  final String backIcon;
  final VoidContextCallback onBackPressed;

  const RelieveScaffold(
      {Key key,
      @required this.childs,
      this.hasBackButton = false,
      this.crossAxisAlignment = CrossAxisAlignment.center,
      this.backIcon = 'images/back_arrow.svg',
      this.onBackPressed = defaultBackPressed});

  List<Widget> _createBody(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    return <Widget>[
      Container(
        // status bar color
        color: AppColor.colorPrimary,
        height: padding.top,
      ),
    ];
  }

  Widget _createBackButton(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.only(left: Dimen.x8, top: Dimen.x8),
      icon: SvgPicture.asset(backIcon, height: 26),
      onPressed: () => onBackPressed(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _body = _createBody(context);

    if (hasBackButton) _body.add(_createBackButton(context));

    _body.addAll(childs);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: _body,
      ),
    );
  }
}
