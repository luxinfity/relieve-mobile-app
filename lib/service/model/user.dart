import 'dart:convert';

import './base.dart';

class Phone {
  final String number;
  final int status;

  Phone(this.number, this.status);

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
  final String fullname;
  final String email;
  final List<Phone> phones;
  final String birthdate;
  final bool isComplete;
  final String gender;

  User({
    this.username,
    this.password,
    this.fullname,
    this.email,
    this.phones,
    this.birthdate,
    this.isComplete,
    this.gender,
  });

  String toJson() {
    return jsonEncode({
      'username': username,
      'password': password,
      'fullname': fullname,
      'email': email,
      // 'phone': phones.map((phone) => phone.toJson()),
      'phones': phones,
      'birthdate': birthdate,
      'gender': gender,
    });
  }

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    try {
      var phonesRaw = parsedJson['phones'] as List;
      List<Phone> phonesParsed =
          phonesRaw.map((i) => Phone.fromJson(i)).toList();

      return User(
        username: parsedJson['username'],
        fullname: parsedJson['fullname'],
        email: parsedJson['email'],
        phones: phonesParsed,
        birthdate: parsedJson['birthdate'],
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
