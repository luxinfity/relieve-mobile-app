import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:relieve_app/datamodel/base.dart';

class Contact {
  final String name;
  final String type;
  final String phone;

  const Contact({
    @required this.name,
    @required this.type,
    @required this.phone,
  });

  String toJson() {
    return jsonEncode({
      'name': name,
      'type': type,
      'phone': phone,
    });
  }

  factory Contact.fromJson(Map<String, dynamic> parsedJson) {
    try {
      return Contact(
        name: parsedJson['name'],
        type: parsedJson['type'],
        phone: parsedJson['phone'],
      );
    } catch (e) {
      return null;
    }
  }
}

class ContactResponse extends BaseResponse {
  @override
  final List<Contact> content;

  ContactResponse({
    String message,
    int status,
    this.content,
  }) : super(message, status, content);

  factory ContactResponse.fromJson(Map<String, dynamic> parsedJson) {
    try {
      return ContactResponse(
        message: parsedJson['message'],
        status: parsedJson['status'],
        content: (parsedJson['content'] as List)
            .map((content) => Contact.fromJson(content))
            .toList(),
      );
    } catch (e) {
      return null;
    }
  }
}
