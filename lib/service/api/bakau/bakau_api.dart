import 'package:relieve_app/datamodel/contact.dart';
import 'package:relieve_app/datamodel/location.dart';
import 'package:relieve_app/service/base/family_service.dart';

abstract class BakauApi implements FamilyService {
  /// Map resource
  Future<ContactResponse> getNearbyEmergencyContact(Coordinate location);
}
