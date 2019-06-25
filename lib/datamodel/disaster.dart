import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:relieve_app/datamodel/location.dart';
import 'package:relieve_app/utils/common_utils.dart';

class DisasterType {
  final String name;

  factory DisasterType(String name) {
    switch (name) {
      case 'quake':
        return QUAKES;
      case 'fire':
        return FIRE;
      case 'flood':
        return FLOOD;
      case 'slide':
        return SLIDE;
      case 'crash':
        return CRASH;
      case 'typhoon':
        return TYPHOON;
      default:
        throw ArgumentError('unidentified DisasterType');
    }
  }

  const DisasterType._internal(this.name);

  static const DisasterType QUAKES = DisasterType._internal("quake");
  static const DisasterType FIRE = DisasterType._internal("fire");
  static const DisasterType FLOOD = DisasterType._internal("flood");
  static const DisasterType SLIDE = DisasterType._internal("slide");
  static const DisasterType CRASH = DisasterType._internal("crash");
  static const DisasterType TYPHOON = DisasterType._internal("typhoon");
}

class DisasterMeta {
  final DocumentSnapshot lastRetrievedDoc;
  final int currentPage;
  final int totalData;

  const DisasterMeta({this.lastRetrievedDoc, this.currentPage, this.totalData});
}

class Disaster {
  final String id;
  final bool isLive;
  final String title;
  final String address;
  final DisasterType disasterType;
  final Coordinate coordinate;
  final double magnitude;
  final double depth;
  final DateTime occursAt;

  Disaster({
    this.id,
    this.isLive,
    this.title,
    this.address,
    this.disasterType,
    this.coordinate,
    this.magnitude,
    this.depth,
    this.occursAt,
  });

  factory Disaster.fromJson(Map<String, dynamic> parsedJson) {
    try {
      return Disaster(
        id: parsedJson['id'],
        isLive: parsedJson['is_live'] ?? false,
        title: parsedJson['title'].toString(),
        address: parsedJson['address'].toString(),
        disasterType: DisasterType(parsedJson['type']),
        coordinate: Coordinate.parseString(parsedJson['coordinate']),
        magnitude: parsedJson['magnitude']?.toDouble() ?? 0,
        depth: parsedJson['depth']?.toDouble() ?? 0,
        occursAt: DateTime.parse(parsedJson['occurs_at']),
      );
    } catch (e) {
      debugLog(Disaster).shout(e);
      return null;
    }
  }
}
