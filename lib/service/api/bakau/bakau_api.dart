import 'package:relieve_app/datamodel/contact.dart';
import 'package:relieve_app/datamodel/location.dart';

abstract class BakauApi {
  /// Map resource
  Future<ContactResponse> getNearbyEmergencyContact(Coordinate location);
}
