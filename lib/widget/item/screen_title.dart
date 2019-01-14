import 'package:flutter/material.dart';

import '../../res/res.dart';

class ScreenTitle extends StatelessWidget {
  final String title;

  const ScreenTitle({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimen.x24,
        horizontal: Dimen.x16,
      ),
      child: Text(title,
          style: CircularStdFont.black.getStyle(size: Dimen.x24)),
    );
  }
}
