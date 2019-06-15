import 'package:relieve_app/datamodel/disaster.dart';

abstract class DisasterService {
  Future<List<DisasterDesc>> getDisasterList(int page, int limit,
      {DisasterType typeFilter});
}
