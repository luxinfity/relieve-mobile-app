import 'package:relieve_app/datamodel/base_response.dart';

class Token {
  final String token;
  final String refreshToken;
  final int expiresIn;

  Token({this.token, this.refreshToken, this.expiresIn});

  factory Token.fromJson(Map<String, dynamic> parsedJson) {
    try {
      return Token(
        token: parsedJson['token'],
        refreshToken: parsedJson['refresh_token'],
        expiresIn: parsedJson['expires_in'],
      );
    } catch (e) {
      return null;
    }
  }
}

class TokenResponse extends BaseResponse<Token> {
  TokenResponse({
    String message,
    int status,
    Token content,
  }) : super(message, status, content);

  factory TokenResponse.fromJson(Map<String, dynamic> parsedJson) {
    try {
      return TokenResponse(
        message: parsedJson['message'],
        status: parsedJson['status'],
        content: Token.fromJson(parsedJson['content']),
      );
    } catch (e) {
      return null;
    }
  }
}
