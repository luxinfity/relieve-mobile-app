import 'package:flutter/foundation.dart';

enum PersonHealth { Fine, Bad, None }

class Family {
  final String fullName;
  final String phoneNumber;
  final String imageUrl;
  final PersonHealth personHealth;

  const Family({
    @required this.fullName,
    this.phoneNumber,
    this.imageUrl,
    this.personHealth,
  });

  String get initials =>
      fullName.toUpperCase().split(' ').map((word) => word[0]).join(' ');
}
