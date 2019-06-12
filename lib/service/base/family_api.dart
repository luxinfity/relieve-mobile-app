import 'package:relieve_app/datamodel/family.dart';
import 'package:relieve_app/datamodel/relieve_user.dart';

abstract class FamilyApi {
  Future<AddFamilyState> addFamily(RelieveUser other);

  Future<AddFamilyState> confirmFamilyAuth(String code);

  Future<List<Family>> getFamilies();
}
