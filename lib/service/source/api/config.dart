import 'package:relieve_app/app_config.dart';

const String DOMAIN = 'relieve.id';
const String secret = 'BdQv7AHrFsAb5JMwYN6OZvCMSn7lU5nB';

// Req Response
const int REQUEST_SUCCESS = 200;

abstract class BaseApi {
  final String serverName = '';
  final AppConfig appConfig;

  String get completeName =>
      '${appConfig.apiUrlPrefix}$serverName.$DOMAIN';

  String get completeUri =>
      '${appConfig.apiProtocol}://${appConfig.apiUrlPrefix}$serverName.$DOMAIN';

  BaseApi(this.appConfig);
}
