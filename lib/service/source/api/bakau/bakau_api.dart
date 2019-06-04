import 'package:relieve_app/service/model/address.dart';
import 'package:relieve_app/service/model/contact.dart';
import 'package:relieve_app/service/model/family.dart';
import 'package:relieve_app/service/model/location.dart';
import 'package:relieve_app/service/model/token.dart';
import 'package:relieve_app/service/model/user.dart';
import 'package:relieve_app/service/model/user_check.dart';

abstract class BakauApi {
  /// Authentication resource
  Future<UserCheckResponse> checkUser(
      UserCheckIdentifier checkIdentifier, String value);

  Future<TokenResponse> login(String username, String password);

  Future<TokenResponse> register(User user);

  /// Families resource
  Future<FamilyResponse> getFamilies();

  /// Map resource
  Future<AddressDetailResponse> getAddressDetailOfPosition(Location position);

  /// Profile resource
  Future<UserResponse> getUser();

  Future<ContactResponse> getNearbyEmergencyContact(Location location);

  Future<AddressResponse> getUserAddress();
}
