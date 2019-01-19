import 'package:flutter/material.dart';

import '../../res/res.dart';

class StandardButton extends StatelessWidget {
  final String text;
  final VoidCallback buttonClick;
  final Color backgroundColor;
  final LocalImage svgIcon;
  final Color textColor;
  final bool isHollow;

  const StandardButton({
    Key key,
    @required this.text,
    @required this.buttonClick,
    @required this.backgroundColor,
    this.svgIcon,
    this.textColor = Colors.white,
    this.isHollow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        top: Dimen.x21,
        left: Dimen.x16,
        right: Dimen.x16,
      ),
      child: isHollow ? _hollowButton() : _filledButton(),
    );
  }

  Widget _hollowButton() {
    return Material(
      elevation: 1,
      color: Colors.white,
      borderRadius: BorderRadius.circular(Dimen.x4),
      child: InkWell(
        onTap: buttonClick,
        child: Container(
          alignment: Alignment.center,
          child: getButtonContent(),
          padding: EdgeInsets.only(
            top: Dimen.x16,
            bottom: Dimen.x16,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimen.x4),
            border: Border.all(color: backgroundColor, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _filledButton() {
    return RaisedButton(
      child: getButtonContent(),
      color: backgroundColor,
      elevation: 1,
      highlightElevation: 1,
      padding: EdgeInsets.only(
        top: Dimen.x16,
        bottom: Dimen.x16,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimen.x4),
      ),
      onPressed: buttonClick,
    );
  }

  Widget getButtonContent() {
    if (svgIcon != null) {
      return Row(
        children: <Widget>[
          Expanded(flex: 1, child: svgIcon.toSvg(height: 20)),
          Expanded(
              flex: 2,
              child: Text(
                text,
                style: CircularStdFont.medium
                    .getStyle(size: Dimen.x14, color: textColor),
              ))
        ],
      );
    } else {
      return Text(
        text,
        style:
            CircularStdFont.medium.getStyle(size: Dimen.x14, color: textColor),
      );
    }
  }
}
