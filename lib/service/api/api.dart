import 'package:relieve_app/datamodel/remote_env.dart';
import 'package:relieve_app/service/api/provider.dart';

const String PROTOCOL = 'https';
const String DOMAIN = 'relieve.id';
const String SECRET = 'BdQv7AHrFsAb5JMwYN6OZvCMSn7lU5nB';

// Req Response
const int REQUEST_SUCCESS = 200;

class Api {
  final RemoteEnv env;

  const Api(this.env);

  String get completeUri {
    if (env.port.isEmpty) {
      return '${env.protocol}://${env.domain}/api/';
    } else {
      return '${env.protocol}://${env.domain}:${env.port}/api/';
    }
  }

  T setProvider<T extends Provider>(T provider) {
    return provider.setUri(completeUri).setSecret(env.secret);
  }

  static const Api PRODUCTION = const Api(RemoteEnv.PRODUCTION);

  static Api _singleton;

  static Api get() {
    if (_singleton == null) {
      RemoteEnv env = RemoteEnv.get();
      if (env != null) {
        _singleton = Api(env);
      } else {
        _singleton = Api.PRODUCTION;
      }
    }

    return _singleton;
  }

  /// only call `Api.reset()` after storing new Env
  static void reset() {
    _singleton = null;
  }
}
