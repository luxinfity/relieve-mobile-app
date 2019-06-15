import 'package:relieve_app/datamodel/contact.dart';
import 'package:relieve_app/datamodel/location.dart';
import 'package:relieve_app/service/base/family_service.dart';
import 'package:relieve_app/service/base/message_service.dart';

abstract class BakauApi implements FamilyService, MessageService {
  /// Map resource
  Future<ContactResponse> getNearbyEmergencyContact(Coordinate location);
}
