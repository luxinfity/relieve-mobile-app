import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  final String gender;
  final Address address;

  User({
    this.username,
    this.password,
    this.fullName,
    this.email,
    this.phones,
    this.birthDate,
    this.gender,
    this.address,
  });

  String toJson({bool onlyFirstPhone = true}) {
    var data = {
      'username': username,
      'password': password,
      'fullName': fullName,
      'email': email,
      'birthDate': birthDate,
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

  factory User.fromQuerySnapshot(QuerySnapshot snapShot) {
    try {
      final rawData = snapShot?.documents?.first;

      return User(
        username: rawData.data['username'],
        fullName: rawData.data['fullName'],
        email: rawData.data['email'],
        birthDate: rawData.data['birthDate'],
        gender: rawData.data['gender'],
      );
    } catch (e) {
      return null;
    }
  }

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    try {
      return User(
        username: parsedJson['username'],
        fullName: parsedJson['fullName'],
        email: parsedJson['email'],
        birthDate: parsedJson['birthDate'],
        gender: parsedJson['gender'],
      );
    } catch (e) {
      return null;
    }
  }

  User copyWith({
    String username,
    String password,
    String fullName,
    String email,
    List<Phone> phones,
    String birthDate,
    String gender,
    Address address,
  }) {
    return User(
      username: username ?? this.username,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phones: phones ?? this.phones,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      address: address ?? this.address,
    );
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
