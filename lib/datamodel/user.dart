import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:relieve_app/datamodel/address.dart';
import 'package:relieve_app/datamodel/base.dart';
import 'package:relieve_app/datamodel/gender.dart';

class User {
  final String username;
  final String password;
  final String fullName;
  final String email;
  final String phone;
  final String birthDate;
  final Gender gender;
  final Address address;

  const User({
    this.username,
    this.password,
    this.fullName,
    this.email,
    this.phone,
    this.birthDate,
    this.gender,
    this.address,
  });

  Map toMap() {
    return {
      'username': username,
      'password': password,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'birthDate': birthDate,
      'gender': gender.label,
      'address': address.toMap(),
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  factory User.fromQuerySnapshot(QuerySnapshot snapShot) {
    try {
      final rawData = snapShot?.documents?.first;

      return User(
        username: rawData.data['username'],
        fullName: rawData.data['fullName'],
        email: rawData.data['email'],
        phone: rawData.data['phone'],
        birthDate: rawData.data['birthDate'],
        gender: Gender(rawData.data['gender']),
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
        phone: parsedJson['phone'],
        birthDate: parsedJson['birthDate'],
        gender: Gender(parsedJson['gender']),
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
    String phone,
    String birthDate,
    Gender gender,
    Address address,
  }) {
    return User(
      username: username ?? this.username,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
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
