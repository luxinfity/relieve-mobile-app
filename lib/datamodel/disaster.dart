import 'package:flutter/foundation.dart';
import 'package:relieve_app/datamodel/base.dart';
import 'package:relieve_app/datamodel/location.dart';

class Disaster {
  final bool isLive;
  final String title;
  final String location;
  final DateTime time;
  final Location coordinate;

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
  final Location coordinate;
  final double magnitude;
  final double depth;
  final DateTime occursAt;

  DisasterDesc({
    this.id,
    this.coordinate,
    this.magnitude,
    this.depth,
    this.occursAt,
  });

  factory DisasterDesc.fromJson(Map<String, dynamic> parsedJson) {
    try {
      return DisasterDesc(
        id: parsedJson['id'],
        coordinate: Location.parseString(parsedJson['coordinates']),
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

class DisasterResponse extends BaseResponse {
  @override
  final DisasterContent content;

  DisasterResponse({
    String message,
    int status,
    this.content,
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
