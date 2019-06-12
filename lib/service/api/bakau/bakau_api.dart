import 'package:relieve_app/datamodel/contact.dart';
import 'package:relieve_app/datamodel/location.dart';
import 'package:relieve_app/service/base/family_api.dart';

abstract class BakauApi implements FamilyApi {
  /// Map resource
  Future<ContactResponse> getNearbyEmergencyContact(Coordinate location);
}
