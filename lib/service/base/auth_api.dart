import 'package:meta/meta.dart';
import 'package:relieve_app/datamodel/token.dart';
import 'package:relieve_app/datamodel/user.dart';
import 'package:relieve_app/datamodel/user_check.dart';

abstract class AuthApi {
  Future<bool> isUserExist(UserCheckIdentifier checkIdentifier, String value);

  Future<bool> login(String username, String password);

  Future<bool> logout();

  @protected
  Future<bool> googleLogin(String accessToken, String idToken);

  Future<User> googleLoginWrap();

  Future<TokenResponse> register(User user);
}
