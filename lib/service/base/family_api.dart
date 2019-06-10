import 'package:relieve_app/datamodel/family.dart';
import 'package:relieve_app/datamodel/relieve_user.dart';

abstract class FamilyApi {
  Future<bool> addFamily(RelieveUser other);

  Future<bool> confirmFamilyAuth(String code);

  Future<List<Family>> getFamilies();
}
