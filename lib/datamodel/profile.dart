import 'dart:convert';

import 'package:relieve_app/datamodel/address.dart';
import 'package:relieve_app/datamodel/base_response.dart';
import 'package:relieve_app/datamodel/gender.dart';

enum ProfileIdentifier { uid, email, username }

class Profile {
  final String username;
  final String password;
  final String fullName;
  final String email;
  final String phone;
  final String birthDate;
  final Gender gender;
  final List<Address> addresses;

  const Profile({
    this.username,
    this.password,
    this.fullName,
    this.email,
    this.phone,
    this.birthDate,
    this.gender,
    this.addresses,
  });

  /// addresses will be dropped
  /// get address map from `addressesToMap()`
  Map<String, dynamic> toMap({bool withAddress = false}) {
    Map<String, dynamic> data = {
      'username': username,
      'password': password,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'birthDate': birthDate,
      'gender': gender.label,
    };

    if (withAddress) {
      data.addAll(addressesToListMap()
          .asMap()
          .map((i, val) => MapEntry(i.toString(), val)));
    }

    return data;
  }

  /// list of addresses in Map`
  List<Map<String, dynamic>> addressesToListMap() {
    return addresses.map((address) => address.toMap()).toList();
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  factory Profile.fromMap(Map snapShot) {
    try {
      return Profile(
        username: snapShot['username'],
        fullName: snapShot['fullName'],
        email: snapShot['email'],
        phone: snapShot['phone'],
        birthDate: snapShot['birthDate'],
        gender: Gender(snapShot['gender']),
      );
    } catch (e) {
      return null;
    }
  }

  Profile copyWith({
    String username,
    String password,
    String fullName,
    String email,
    String phone,
    String birthDate,
    Gender gender,
    List<Address> addresses,
  }) {
    return Profile(
      username: username ?? this.username,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      addresses: addresses ?? this.addresses,
    );
  }
}

class ProfileResponse extends BaseResponse {
  @override
  final Profile content;

  ProfileResponse({
    String message,
    int status,
    this.content,
  }) : super(message, status, content);

  factory ProfileResponse.fromJson(Map<String, dynamic> parsedJson) {
    try {
      return ProfileResponse(
        message: parsedJson['message'],
        status: parsedJson['status'],
        content: Profile.fromMap(parsedJson['content']),
      );
    } catch (e) {
      return null;
    }
  }
}
