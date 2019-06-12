import 'package:flutter/foundation.dart';
import 'package:relieve_app/datamodel/base_response.dart';
import 'package:relieve_app/datamodel/location.dart';

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

class Disaster {
  final bool isLive;
  final String title;
  final String location;
  final DateTime time;
  final Coordinate coordinate;

  const Disaster({
    @required this.isLive,
    @required this.title,
    @required this.location,
    @required this.time,
    @required this.coordinate,
  });
}

class DisasterMeta {
  final int totalPage;
  final int page;
  final int limit;

  DisasterMeta({
    this.totalPage,
    this.page,
    this.limit,
  });

  factory DisasterMeta.fromJson(Map<String, dynamic> parsedJson) {
    try {
      return DisasterMeta(
        totalPage: parsedJson['total_page'],
        page: parsedJson['page'],
        limit: parsedJson['limit'],
      );
    } catch (e) {
      return null;
    }
  }
}

class DisasterDesc {
  final String id;
  final DisasterType disasterType;
  final Coordinate coordinate;
  final double magnitude;
  final double depth;
  final DateTime occursAt;

  DisasterDesc({
    this.id,
    this.disasterType,
    this.coordinate,
    this.magnitude,
    this.depth,
    this.occursAt,
  });

  factory DisasterDesc.fromJson(Map<String, dynamic> parsedJson) {
    try {
      return DisasterDesc(
        id: parsedJson['id'],
        disasterType: DisasterType(parsedJson['type']),
        coordinate: Coordinate.parseString(parsedJson['coordinate']),
        magnitude: parsedJson['magnitude'].toDouble(),
        depth: parsedJson['depth'].toDouble(),
        occursAt: DateTime.parse(parsedJson['occurs_at']),
      );
    } catch (e) {
      return null;
    }
  }
}

class DisasterContent {
  final List<DisasterDesc> data;
  final DisasterMeta meta;

  DisasterContent({this.data, this.meta});

  factory DisasterContent.fromJson(Map<String, dynamic> parsedJson) {
    try {
      return DisasterContent(
        data: (parsedJson['data'] as List)
            .map((content) => DisasterDesc.fromJson(content))
            .toList(),
        meta: DisasterMeta.fromJson(parsedJson['meta']),
      );
    } catch (e) {
      return null;
    }
  }
}

class DisasterResponse extends BaseResponse<DisasterContent> {
  DisasterResponse({
    String message,
    int status,
    DisasterContent content,
  }) : super(message, status, content);

  factory DisasterResponse.fromJson(Map<String, dynamic> parsedJson) {
    try {
      return DisasterResponse(
        message: parsedJson['message'],
        status: parsedJson['status'],
        content: DisasterContent.fromJson(parsedJson['content']),
      );
    } catch (e) {
      return null;
    }
  }
}
