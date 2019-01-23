class BaseResponse {
  final String message;
  final int status;
  final dynamic content;

  BaseResponse(this.message, this.status, this.content);
}

class Token {
  final String token;
  final String refreshToken;
  final int expiresIn;

  Token({this.token, this.refreshToken, this.expiresIn});

  factory Token.fromJson(Map<String, dynamic> parsedJson) {
    return Token(
      token: parsedJson['token'],
      refreshToken: parsedJson['refresh_token'],
      expiresIn: parsedJson['expires_in'],
    );
  }
}
