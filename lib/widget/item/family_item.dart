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

  Widget _createNormalItem() {
    return Center(
      child: Text('Normal'),
    );
  }

  Widget _createEmptyItem() {
    return Center(
      child: Text('Empty'),
    );
  }

  Widget _createAddItem() {
    return Center(
      child: Text('Add'),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case FamilyItemType.Normal:
        return _createNormalItem();
      case FamilyItemType.Empty:
        return _createEmptyItem();
      case FamilyItemType.Add:
        return _createAddItem();
    }
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
