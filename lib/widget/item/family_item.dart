import 'package:flutter/material.dart';
import 'package:dashed_circle/dashed_circle.dart';

import '../../res/res.dart';

class FamilyItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final bool isFine;

  const FamilyItem({
    Key key,
    this.imageUrl = '',
    @required this.name,
    this.isFine = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final initial =
        name.split(' ').map((word) => word[0].toUpperCase()).join(' ');
    return Container(
      width: 50,
      height: 50,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: isFine ? AppColor.colorPrimary : AppColor.colorDanger,
        ),
        shape: BoxShape.circle,
      ),
      // child: Center(child: Text(initial)),
      child: CircleAvatar(
        radius: Dimen.x24,
        backgroundImage: imageUrl.isEmpty ? null : NetworkImage(imageUrl),
        child: imageUrl.isEmpty ? Text(initial) : null,
      ),
    );
  }
}
