import 'package:relieve_app/datamodel/address.dart';
import 'package:relieve_app/datamodel/profile.dart';
import 'package:relieve_app/datamodel/relieve_user.dart';

abstract class ProfileService {
  Future<bool> storeProfile(String uid, Profile profile);

  Future<bool> addAddress(String uid, Address address);

  Future<bool> updateAddress(Address address);

  Future<List<Address>> getAddress();

  Future<bool> isProfileExist(ProfileIdentifier checkIdentifier, String value);

  Future<RelieveUser> findUserBy(
    ProfileIdentifier checkIdentifier,
    String value,
  );
}
