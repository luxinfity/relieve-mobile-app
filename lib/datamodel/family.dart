import 'package:flutter/foundation.dart';
import 'package:relieve_app/datamodel/base.dart';
import 'package:relieve_app/datamodel/location.dart';

enum PersonHealth { Fine, Bad, None }

class Condition {
  final PersonHealth health;
  final Location location;
  final String date;

  const Condition({
    this.health = PersonHealth.Fine,
    this.location = const Location(0.0, 0.0),
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
        location: Location.parseString(parsedJson['location']),
        date: parsedJson['date'],
      );
    } catch (e) {
      return null;
    }
  }
}

class Family {
  final String id;
  final String fullName;
  final String nickName;
  final String role;
  final String phoneNumber;
  final String imageUrl;
  final Condition condition;

  const Family({
    this.id = '',
    @required this.fullName,
    this.nickName = '',
    this.role = '',
    this.phoneNumber = '',
    this.imageUrl = '',
    this.condition = const Condition(),
  });

  String get initials =>
      fullName.toUpperCase().split(' ').map((word) => word[0]).join(' ');

  factory Family.fromJson(Map<String, dynamic> parsedJson) {
    try {
      // TODO: handle non existent value
      return Family(
        id: parsedJson['id'],
        fullName: parsedJson['fullName'],
        nickName: parsedJson['nick'],
        role: parsedJson['role'],
        phoneNumber: parsedJson['phoneNumber'],
        imageUrl: parsedJson['imageUrl'],
        condition: Condition.fromJson(parsedJson['condition']),
      );
    } catch (e) {
      return null;
    }
  }
}

class FamilyResponse extends BaseResponse {
  @override
  final List<Family> content;

  FamilyResponse({
    String message,
    int status,
    this.content,
  }) : super(message, status, content);

  factory FamilyResponse.fromJson(Map<String, dynamic> parsedJson) {
    try {
      return FamilyResponse(
        message: parsedJson['message'],
        status: parsedJson['status'],
        content: (parsedJson['content'] as List)
            .map((content) => Family.fromJson(content))
            .toList(),
      );
    } catch (e) {
      return null;
    }
  }
}
