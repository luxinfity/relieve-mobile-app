import 'dart:convert';

import 'package:relieve_app/datamodel/address.dart';
import 'package:relieve_app/datamodel/base.dart';

class Phone {
  final String number;
  final int status;

  Phone(this.number, this.status);

  Map toMap() {
    return {
      'number': number,
      'status': status,
    };
  }

  String toJson() {
    return jsonEncode({
      'number': number,
      'status': status,
    });
  }

  factory Phone.fromJson(Map<String, dynamic> parsedJson) {
    try {
      return Phone(
        parsedJson['number'],
        parsedJson['status'],
      );
    } catch (e) {
      return null;
    }
  }
}

class User {
  final String username;
  final String password;
  final String fullName;
  final String email;
  final List<Phone> phones;
  final String birthDate;
  final bool isComplete;
  final String gender;
  final Address address;

  User({
    this.username,
    this.password,
    this.fullName,
    this.email,
    this.phones,
    this.birthDate,
    this.isComplete,
    this.gender,
    this.address,
  });

  String toJson({bool onlyFirstPhone = true}) {
    var data = {
      'username': username,
      'password': password,
      'fullname': fullName,
      'email': email,
      'birthdate': birthDate,
      'gender': gender,
      'address': address.toMap(),
    };

    if (onlyFirstPhone) {
      data['phone'] = phones[0].number;
    } else {
      data['phones'] = phones.map((phone) => phone.toMap());
    }

    return jsonEncode(data);
  }

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    try {
      return User(
        username: parsedJson['username'],
        fullName: parsedJson['fullname'],
        email: parsedJson['email'],
        birthDate: parsedJson['birthdate'],
        isComplete: parsedJson['is_complete'],
        gender: parsedJson['gender'],
      );
    } catch (e) {
      return null;
    }
  }
}

class UserResponse extends BaseResponse {
  @override
  final User content;

  UserResponse({
    String message,
    int status,
    this.content,
  }) : super(message, status, content);

  factory UserResponse.fromJson(Map<String, dynamic> parsedJson) {
    try {
      return UserResponse(
        message: parsedJson['message'],
        status: parsedJson['status'],
        content: User.fromJson(parsedJson['content']),
      );
    } catch (e) {
      return null;
    }
  }
}
