import 'package:flutter/foundation.dart';
import 'package:relieve_app/datamodel/location.dart';
import 'package:relieve_app/datamodel/profile.dart';
import 'package:relieve_app/datamodel/relieve_user.dart';

enum Health { Fine, Bad, None }

class Condition {
  final Health health;
  final Coordinate location;
  final String date;

  const Condition({
    this.health = Health.Fine,
    this.location = const Coordinate(0.0, 0.0),
    this.date = '2019-01-01', // TODO: remove default date
  });

  factory Condition.fromJson(Map<String, dynamic> parsedJson) {
    try {
      Health health = Health.None;
      int status = parsedJson['status'];
      // enum from backend = [10,20,30] => none, fine, bad
      if (status == 20) {
        health = Health.Fine;
      } else if (status == 30) {
        health = Health.Bad;
      } else {
        health = Health.None;
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
  final Condition condition;

  const Family({
    @required String uid,
    @required Profile profile,
    String label = '',
    this.condition = const Condition(),
  }) : super(uid, profile, label: label);

  String get initials => super
      .profile
      .fullName
      .split(' ')
      .map((word) => word[0].toUpperCase())
      .join('');

  Family copyWith({
    String uid,
    Profile profile,
    String label,
    Condition condition,
  }) {
    return Family(
      uid: uid ?? this.uid,
      profile: profile ?? this.profile,
      label: label ?? this.label,
      condition: condition ?? this.condition,
    );
  }
}
