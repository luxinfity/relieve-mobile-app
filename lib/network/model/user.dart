import 'dart:convert';

class User {
  final String username;
  final String password;
  final String fullname;
  final String email;
  final String phone;
  final String birthdate;
  final String gender;

  User({
    this.username,
    this.password,
    this.fullname,
    this.email,
    this.phone,
    this.birthdate,
    this.gender,
  });

  String toJson() {
    return jsonEncode({
      'username' : username,
      'password' : password,
      'fullname' : fullname,
      'email' : email,
      'phone' : phone,
      'birthdate' : birthdate,
      'gender' : gender,
    });
  }

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    try {
      return User(
        username: parsedJson['username'],
        fullname: parsedJson['fullname'],
        email: parsedJson['email'],
        phone: parsedJson['phone'],
        birthdate: parsedJson['birthdate'],
        gender: parsedJson['gender'],
      );
    } catch (e) {
      return null;
    }
  }
}
