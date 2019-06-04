import 'package:relieve_app/service/model/token.dart';
import 'package:relieve_app/service/model/user.dart';
import 'package:relieve_app/service/model/user_check.dart';

abstract class AuthApi {
  Future<UserCheckResponse> checkUser(
      UserCheckIdentifier checkIdentifier, String value);

  Future<TokenResponse> login(String username, String password);

  Future<TokenResponse> register(User user);
}
