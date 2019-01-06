import 'package:flutter/material.dart';

import '../../res/font.dart';
import '../../res/color.dart';
import '../../res/numbers.dart';

enum RelieveTitleStyle { light, dark }

class RelieveTitle extends StatelessWidget {
  final RelieveTitleStyle style;

  const RelieveTitle({Key key, this.style = RelieveTitleStyle.dark})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimen.x16),
      width: double.infinity,
      child: Text(
        'Relieve',
        style: CircularStdFont.getFont(
                style: CircularStdFontStyle.Black, size: Dimen.x18)
            .apply(
                color: (style == RelieveTitleStyle.dark)
                    ? AppColor.colorPrimary
                    : Colors.white),
      ),
    );
  }
}
