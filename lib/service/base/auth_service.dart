import 'package:meta/meta.dart';
import 'package:relieve_app/datamodel/profile.dart';
import 'package:relieve_app/datamodel/relieve_user.dart';

abstract class AuthService {
  Future<bool> isUserExist(ProfileIdentifier checkIdentifier, String value);

  Future<bool> login(String username, String password);

  Future<bool> logout();

  @protected
  Future<bool> googleLogin(String accessToken, String idToken);

  Future<RelieveUser> googleLoginWrap();

  Future<bool> register(Profile profile);
}
