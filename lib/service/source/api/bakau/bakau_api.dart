import 'package:relieve_app/service/model/address.dart';
import 'package:relieve_app/service/model/contact.dart';
import 'package:relieve_app/service/model/family.dart';
import 'package:relieve_app/service/model/location.dart';
import 'package:relieve_app/service/model/user.dart';
import 'package:relieve_app/service/source/api/bakau/auth_api.dart';

abstract class BakauApi implements AuthApi {
  /// Families resource
  Future<FamilyResponse> getFamilies();

  /// Map resource
  Future<AddressDetailResponse> getAddressDetailOfPosition(Location position);

  /// Profile resource
  Future<UserResponse> getUser();

  Future<ContactResponse> getNearbyEmergencyContact(Location location);

  Future<AddressResponse> getUserAddress();
}
