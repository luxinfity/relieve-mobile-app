import 'package:relieve_app/datamodel/family.dart';
import 'package:relieve_app/datamodel/relieve_user.dart';

abstract class FamilyService {
  Future<AddFamilyState> addFamily(RelieveUser other);

  Future<bool> editFamilyLabel(RelieveUser other, String label);

  Future<AddFamilyState> confirmFamilyAuth(String code);

  Future<List<Family>> getFamilies();
}
