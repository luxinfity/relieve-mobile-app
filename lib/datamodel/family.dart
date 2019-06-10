import 'package:flutter/foundation.dart';
import 'package:relieve_app/datamodel/location.dart';
import 'package:relieve_app/datamodel/profile.dart';
import 'package:relieve_app/datamodel/relieve_user.dart';

enum PersonHealth { Fine, Bad, None }

class Condition {
  final PersonHealth health;
  final Coordinate location;
  final String date;

  const Condition({
    this.health = PersonHealth.Fine,
    this.location = const Coordinate(0.0, 0.0),
    this.date = '01-01-2019', // TODO: remove default date
  });

  factory Condition.fromJson(Map<String, dynamic> parsedJson) {
    try {
      PersonHealth health = PersonHealth.None;
      int status = parsedJson['status'];
      // enum from backend = [10,20,30] => none, fine, bad
      if (status == 20) {
        health = PersonHealth.Fine;
      } else if (status == 30) {
        health = PersonHealth.Bad;
      } else {
        health = PersonHealth.None;
      }
      return Condition(
        health: health,
        location: Coordinate.parseString(parsedJson['location']),
        date: parsedJson['date'],
      );
    } catch (e) {
      return null;
    }
  }
}

class Family extends RelieveUser {
  // TODO: move image to profile
  final String imageUrl;
  final Condition condition;

  const Family({
    @required String uid,
    @required Profile profile,
    String label = '',
    this.imageUrl = '',
    this.condition = const Condition(),
  }) : super(uid, null, label: label);

  String get initials => super
      .profile
      .fullName
      .split(' ')
      .map((word) => word[0].toUpperCase())
      .join('');
}
