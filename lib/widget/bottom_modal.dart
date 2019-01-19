import 'package:flutter/material.dart';

import '../res/res.dart';

void createRelieveBottomModal(BuildContext context, List<Widget> children) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      final padding = MediaQuery.of(context).padding;
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimen.x16,
          vertical: padding.bottom,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimen.x16),
            topRight: Radius.circular(Dimen.x16),
          ),
        ),
        child: Wrap(
          direction: Axis.vertical,
          children: children,
        ),
      );
    },
  );
}
