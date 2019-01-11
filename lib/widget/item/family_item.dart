import 'package:flutter/material.dart';

enum FamilyItemType { Normal, Empty, Add }

enum FamilyItemHealth { Fine, Bad, None }

class FamilyItem extends StatelessWidget {
  final FamilyItemType type;
  final FamilyItemHealth health;
  final String fullName;
  final String imageUrl;

  const FamilyItem({
    Key key,
    this.type,
    this.health,
    this.fullName,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Alif'),
    );
  }

  static FamilyItem empty() {
    return FamilyItem();
  }

  static FamilyItem add() {
    return FamilyItem();
  }

  static FamilyItem normal() {
    return FamilyItem();
  }
}
