import 'package:flutter/material.dart';

import '../../../res/res.dart';

class ItemButton extends StatelessWidget {
  final LocalImage icon;
  final String title;
  final bool isTintBlue;
  final VoidCallback onClick;

  const ItemButton({
    Key key,
    this.icon,
    this.title,
    this.isTintBlue = false,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(Dimen.x4),
        onTap: onClick,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimen.x14, vertical: Dimen.x18),
          child: Wrap(
            direction: Axis.vertical,
            spacing: Dimen.x10,
            children: <Widget>[
              icon.toSvg(
                width: Dimen.x18,
                color: isTintBlue
                    ? AppColor.colorPrimary
                    : AppColor.colorTextBlack,
              ),
              Text(
                title,
                style: CircularStdFont.medium.getStyle(
                  size: Dimen.x14,
                  color: isTintBlue
                      ? AppColor.colorPrimary
                      : AppColor.colorTextBlack,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
