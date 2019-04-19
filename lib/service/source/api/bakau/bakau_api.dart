import 'package:relieve_app/service/service.dart';
import 'package:relieve_app/service/source/api/bakau/authentication.dart';
import 'package:relieve_app/service/source/api/bakau/family.dart';
import 'package:relieve_app/service/source/api/bakau/maps.dart';
import 'package:relieve_app/service/source/api/bakau/profile.dart';
import 'package:relieve_app/service/source/api/base.dart';
import 'package:relieve_app/widget/inherited/app_config.dart';

class BakauApi extends BaseApi with Authentication, Profile, Family, Maps {
  @override
  final String serverName = 'bakau';

  BakauApi(AppConfig appConfig) : super(appConfig);
}
