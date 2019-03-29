import "package:flutter/material.dart";
import "package:relieve_app/res/res.dart";

class StandardButton extends StatelessWidget {
  final String text;
  final VoidCallback buttonClick;
  final Color backgroundColor;
  final LocalImage svgIcon;
  final Color textColor;
  final bool isHollow;
  final bool isCenteredIcon;

  const StandardButton({
    Key key,
    @required this.text,
    @required this.buttonClick,
    @required this.backgroundColor,
    this.svgIcon,
    this.isCenteredIcon = false,
    this.textColor = Colors.white,
    this.isHollow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        top: Dimen.x16,
        left: Dimen.x16,
        right: Dimen.x16,
      ),
      child: _createButton(),
    );
  }

  Widget _createButton() {
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
        side: isHollow
            ? BorderSide.none
            : BorderSide(color: backgroundColor, width: 2),
      ),
      onPressed: buttonClick,
    );
  }

  Widget getButtonContent() {
    if (svgIcon != null && isCenteredIcon) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          svgIcon.toSvg(height: 20),
          Container(width: Dimen.x16),
          Text(
            text,
            style: CircularStdFont.medium
                .getStyle(size: Dimen.x14, color: textColor),
          ),
        ],
      );
    } else if (svgIcon != null) {
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
