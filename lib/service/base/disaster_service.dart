import 'package:relieve_app/datamodel/disaster.dart';

abstract class DisasterService {
  Future<Disaster> getLiveEvent();

  Future<List<Disaster>> getDisasterList(int page, int limit,
      {DisasterType typeFilter});
}
