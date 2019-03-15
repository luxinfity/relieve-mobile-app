import 'package:flutter/material.dart';
import 'package:relieve_app/res/res.dart';
import 'package:relieve_app/utils/common_utils.dart';

class RelieveScaffold extends StatelessWidget {
  final List<Widget> childs;
  final CrossAxisAlignment crossAxisAlignment;
  final bool hasBackButton;
  final bool hasAppBarScreen;
  final LocalImage backIcon;
  final Widget bottomNavigationBar;
  final VoidContextCallback onBackPressed;
  final int progressCount;
  final int progressTotal;

  const RelieveScaffold(
      {Key key,
      @required this.childs,
      this.hasBackButton = false,
      this.hasAppBarScreen = false,
      this.crossAxisAlignment = CrossAxisAlignment.center,
      this.backIcon,
      this.bottomNavigationBar,
      this.onBackPressed = defaultBackPressed,
      this.progressCount = 0,
      this.progressTotal = 100});

  List<Widget> _createBody(BuildContext context, EdgeInsets padding) {
    return <Widget>[
      // status bar
      hasAppBarScreen
          ? null
          : Container(
              color: AppColor.colorPrimary,
              height: padding.top,
            ),
      Container(
        height: Dimen.x4,
        child: LinearProgressIndicator(
          value: progressCount / progressTotal,
          valueColor: AlwaysStoppedAnimation<Color>(AppColor.colorPrimary),
        ),
      ),
    ].where((widget) => widget != null).toList();
  }

  Widget _createBackButton(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.only(left: Dimen.x8, top: Dimen.x8),
      icon: (backIcon ?? LocalImage.ic_back_arrow).toSvg(height: 26),
      onPressed: () => onBackPressed(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    final _body = _createBody(context, padding);

    if (hasBackButton) _body.add(_createBackButton(context));
    _body.addAll(childs);

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: bottomNavigationBar,
      body: Container(
        padding: EdgeInsets.only(left: padding.left, right: padding.right),
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          children: _body,
        ),
      ),
    );
  }
}
