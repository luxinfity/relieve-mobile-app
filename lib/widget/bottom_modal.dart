import "package:flutter/material.dart";
import "package:relieve_app/res/res.dart";

double _calculatePaddingBottom(BuildContext context) {
  final padding = MediaQuery.of(context).padding;
  if (Theme.of(context).platform == TargetPlatform.iOS) {
    return padding.bottom;
  } else {
    return padding.bottom + Dimen.x16;
  }
}

Future createRelieveBottomModal(BuildContext context, List<Widget> children) {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.only(
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
