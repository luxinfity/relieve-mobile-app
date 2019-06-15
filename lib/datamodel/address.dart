import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:relieve_app/datamodel/base_response.dart';
import 'package:relieve_app/datamodel/location.dart';

class Address {
  final String uuid;
  final String label;
  final String street;
  final Coordinate coordinate;

  const Address({
    this.uuid,
    @required this.label,
    @required this.street,
    @required this.coordinate,
  });

  Map<String, dynamic> toMap() {
    return {
      'label': label,
      'street': street,
      'coordinate': coordinate.toString()
    };
  }

  String toJson() {
    return jsonEncode({
      'uuid': uuid,
      'label': label,
      'street': street,
      'coordinate': coordinate.toString(),
    });
  }

  factory Address.fromJson(Map<String, dynamic> parsedJson, [String uuid]) {
    try {
      return Address(
        uuid: parsedJson['uuid'] ?? uuid,
        label: parsedJson['label'],
        street: parsedJson['street'],
        coordinate: Coordinate.parseString(parsedJson['coordinate']),
      );
    } catch (e) {
      return null;
    }
  }
}

class AddressResponse extends BaseResponse<List<Address>> {
  AddressResponse({
    String message,
    int status,
    List<Address> content,
  }) : super(message, status, content);

  factory AddressResponse.fromJson(Map<String, dynamic> parsedJson) {
    try {
      return AddressResponse(
        message: parsedJson['message'],
        status: parsedJson['status'],
        content: (parsedJson['content'] as List)
            .map((content) => Address.fromJson(content))
            .toList(),
      );
    } catch (e) {
      return null;
    }
  }
}
