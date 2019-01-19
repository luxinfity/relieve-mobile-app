import 'package:flutter/material.dart';

import '../res/res.dart';

double _calculatePaddingBottom(BuildContext context) {
  final padding = MediaQuery.of(context).padding;
  if (Theme.of(context).platform == TargetPlatform.iOS) {
    return padding.bottom + Dimen.x16;
  } else {
    return padding.bottom + Dimen.x32;
  }
}

void createRelieveBottomModal(BuildContext context, List<Widget> children) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      Wrap(
        
      );
      return Container(
        padding: EdgeInsets.only(
          left: Dimen.x16,
          right: Dimen.x16,
          top: Dimen.x16,
          bottom: _calculatePaddingBottom(context),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimen.x16),
            topRight: Radius.circular(Dimen.x16),
          ),
        ),
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: children,
        ),
      );
    },
  );
}
