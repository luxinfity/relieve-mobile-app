import 'package:flutter/material.dart';

import '../../../res/res.dart';

class ItemButton extends StatelessWidget {
  final LocalImage icon;
  final String title;
  final bool isTintBlue;
  final bool isEditMode;
  final bool isSelected;
  final VoidCallback onClick;

  const ItemButton({
    Key key,
    this.icon,
    this.title,
    this.isTintBlue = false,
    this.isEditMode = false,
    this.isSelected = false,
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
          child: Stack(
            children: <Widget>[
              Column(
                // direction: Axis.vertical,
                // spacing: Dimen.x10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  icon.toSvg(
                    width: Dimen.x18,
                    color: isTintBlue
                        ? AppColor.colorPrimary
                        : AppColor.colorTextBlack,
                  ),
                  Container(height: Dimen.x10),
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
              Container(
                alignment: Alignment.topRight,
                child: isEditMode
                    ? LocalImage.ic_check.toSvg(
                        width: Dimen.x16,
                        color: isSelected
                            ? AppColor.colorPrimary
                            : AppColor.colorEmptyChip,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
