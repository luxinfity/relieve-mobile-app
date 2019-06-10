import 'package:relieve_app/datamodel/address.dart';
import 'package:relieve_app/datamodel/contact.dart';
import 'package:relieve_app/datamodel/family.dart';
import 'package:relieve_app/datamodel/location.dart';
import 'package:relieve_app/datamodel/profile.dart';
import 'package:relieve_app/service/base/auth_api.dart';

abstract class BakauApi implements AuthApi {
  /// Families resource
  Future<FamilyResponse> getFamilies();

  /// Map resource
  Future<AddressDetailResponse> getAddressDetailOfPosition(Coordinate position);

  /// Profile resource
  Future<ProfileResponse> getUser();

  Future<ContactResponse> getNearbyEmergencyContact(Coordinate location);

  Future<AddressResponse> getUserAddress();
}
