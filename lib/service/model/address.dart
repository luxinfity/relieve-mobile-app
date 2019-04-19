import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:relieve_app/service/model/base.dart';
import 'package:relieve_app/service/model/location.dart';

class AddressDetail {
  final String area1;
  final String area2;
  final String area3;
  final String area4;

  final String street;
  final String country;
  final String zipCode;

  const AddressDetail({
    this.area1,
    this.area2,
    this.area3,
    this.area4,
    this.street,
    this.country,
    this.zipCode,
  });

  Map toMap() {
    return {
      'country': country,
      'zip_code': zipCode,
      'street': street,
      'area_1': area1,
      'area_2': area2,
      'area_3': area3,
      'area_4': area4,
    };
  }

  String toJson() {
    return jsonEncode({
      'country': country,
      'zip_code': zipCode,
      'street': street,
      'area_1': area1,
      'area_2': area2,
      'area_3': area3,
      'area_4': area4,
    });
  }

  factory AddressDetail.fromJson(Map<String, dynamic> parsedJson) {
    try {
      return AddressDetail(
        country: parsedJson['country'],
        zipCode: parsedJson['zip_code'],
        street: parsedJson['street'],
        area1: parsedJson['area_1'],
        area2: parsedJson['area_2'],
        area3: parsedJson['area_3'],
        area4: parsedJson['area_4'],
      );
    } catch (e) {
      return null;
    }
  }
}

class Address {
  final String uuid;
  final String name;
  final Location location;
  final AddressDetail details;

  const Address({
    @required this.uuid,
    @required this.name,
    @required this.location,
    this.details,
  });

  Map toMap() {
    return {
      'uuid': uuid,
      'name': name,
      'coordinates': location.toString(),
      'details': details?.toMap(),
    };
  }

  String toJson() {
    return jsonEncode({
      'uuid': uuid,
      'name': name,
      'coordinates': location.toString(),
      'details': details?.toMap(),
    });
  }

  factory Address.fromJson(Map<String, dynamic> parsedJson) {
    try {
      return Address(
        uuid: parsedJson['uuid'],
        name: parsedJson['name'],
        location: Location.parseString(parsedJson['coordinates']),
        details: AddressDetail.fromJson(parsedJson['details']),
      );
    } catch (e) {
      return null;
    }
  }
}

class AddressDetailResponse extends BaseResponse {
  @override
  final AddressDetail content;

  AddressDetailResponse({
    String message,
    int status,
    this.content,
  }) : super(message, status, content);

  factory AddressDetailResponse.fromJson(Map<String, dynamic> parsedJson) {
    try {
      return AddressDetailResponse(
        message: parsedJson['message'],
        status: parsedJson['status'],
        content: AddressDetail.fromJson(parsedJson['content']),
      );
    } catch (e) {
      return null;
    }
  }
}

class AddressResponse extends BaseResponse {
  @override
  final List<Address> content;

  AddressResponse({
    String message,
    int status,
    this.content,
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
