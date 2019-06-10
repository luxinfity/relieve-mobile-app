import 'package:relieve_app/datamodel/contact.dart';
import 'package:relieve_app/datamodel/family.dart';
import 'package:relieve_app/datamodel/location.dart';

abstract class BakauApi {
  /// Families resource
  Future<FamilyResponse> getFamilies();

  /// Map resource
  Future<ContactResponse> getNearbyEmergencyContact(Coordinate location);
}
