import 'package:relieve_app/datamodel/relieve_user.dart';

abstract class FamilyApi {
  Future<bool> addFamily(RelieveUser other);

  Future<List<RelieveUser>> getFamilies();
}
