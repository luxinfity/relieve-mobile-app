import 'package:relieve_app/datamodel/family.dart';
import 'package:relieve_app/datamodel/relieve_user.dart';

abstract class FamilyService {
  Future<AddFamilyState> addFamily(RelieveUser other);

  Future<AddFamilyState> confirmFamilyAuth(String code);

  Future<bool> editFamilyLabel(RelieveUser other, String label);

  Future<List<Family>> getFamilies();
}
