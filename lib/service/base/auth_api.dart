import 'package:meta/meta.dart';
import 'package:relieve_app/datamodel/profile.dart';
import 'package:relieve_app/datamodel/user_check.dart';

abstract class AuthApi {
  Future<bool> isUserExist(UserCheckIdentifier checkIdentifier, String value);

  Future<bool> login(String username, String password);

  Future<bool> logout();

  @protected
  Future<bool> googleLogin(String accessToken, String idToken);

  Future<Profile> googleLoginWrap();

  Future<bool> register(Profile profile);
}
