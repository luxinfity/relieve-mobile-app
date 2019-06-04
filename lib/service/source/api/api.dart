import 'package:relieve_app/service/source/api/provider.dart';
import 'package:relieve_app/utils/preference_utils.dart' as pref;

const String PROTOCOL = 'https';
const String DOMAIN = 'relieve.id';
const String SECRET = 'BdQv7AHrFsAb5JMwYN6OZvCMSn7lU5nB';

// Req Response
const int REQUEST_SUCCESS = 200;

class Api {
  final String protocol;
  final String domain;
  final String port;
  final String secret;

  Api(this.protocol, this.domain, this.port, this.secret);

  String get completeUri {
    if (port == null) {
      return '$protocol://$domain/api/';
    } else {
      return '$protocol://$domain:$port/api/';
    }
  }

  T setProvider<T extends Provider>(T provider) {
    return provider.setUri(completeUri).setSecret(secret);
  }

  factory Api._production() {
    return Api(PROTOCOL, DOMAIN, null, SECRET);
  }

  factory Api._debug({
    String protocol = PROTOCOL,
    String domain = "staging.$DOMAIN",
    String port = "80",
    String secret = SECRET,
  }) {
    return Api(protocol, domain, port, secret);
  }

  static Api _singleton;
  static Api get() {
    if (_singleton == null) {

    }

    return _singleton;
  }
}
