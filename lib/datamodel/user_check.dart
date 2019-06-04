import 'package:relieve_app/datamodel/base.dart';

enum UserCheckIdentifier { email, username }

class UserCheck {
  final String param;
  final String value;
  final bool isExsist;

  UserCheck({this.param, this.value, this.isExsist});

  factory UserCheck.fromJson(Map<String, dynamic> parsedJson) {
    try {
      return UserCheck(
        param: parsedJson['token'],
        value: parsedJson['refresh_token'],
        isExsist: parsedJson['is_exsist'],
      );
    } catch (e) {
      return null;
    }
  }
}

class UserCheckResponse extends BaseResponse {
  @override
  final UserCheck content;

  UserCheckResponse({
    String message,
    int status,
    this.content,
  }) : super(message, status, content);

  factory UserCheckResponse.fromJson(Map<String, dynamic> parsedJson) {
    try {
      return UserCheckResponse(
        message: parsedJson['message'],
        status: parsedJson['status'],
        content: UserCheck.fromJson(parsedJson['content']),
      );
    } catch (e) {
      return null;
    }
  }
}
