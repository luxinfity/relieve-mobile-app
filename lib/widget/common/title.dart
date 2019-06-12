import 'package:flutter/material.dart';
import 'package:relieve_app/res/export.dart';

class ThemedTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  ThemedTitle({
    @required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: Dimen.x16,
        right: Dimen.x16,
        top: Dimen.x8,
        bottom: Dimen.x8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: CircularStdFont.bold.getStyle(size: 22)),
          SizedBox(
            height: 6,
          ),
          subtitle != null
              ? Text(
                  subtitle,
                  style: CircularStdFont.book
                      .getStyle(size: 14, color: AppColor.colorTextGrey),
                )
              : null,
        ].where((widget) => widget != null).toList(),
      ),
    );
  }
}

class ScreenTitle extends StatelessWidget {
  final String title;

  const ScreenTitle({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title, style: CircularStdFont.black.getStyle(size: Dimen.x24));
  }
}
