import 'package:relieve_app/datamodel/profile.dart';
import 'package:relieve_app/datamodel/relieve_user.dart';

abstract class ProfileApi {
  Future<bool> storeProfile(String uid, Profile profile);

  Future<bool> isProfileExist(ProfileIdentifier checkIdentifier, String value);

  Future<RelieveUser> findUserBy(
    ProfileIdentifier checkIdentifier,
    String value,
  );
}
