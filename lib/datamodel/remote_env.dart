import 'package:flutter_keychain/flutter_keychain.dart';

const String PROTOCOL = 'https';
const String DOMAIN = 'relieve.id';
const String SECRET = 'BdQv7AHrFsAb5JMwYN6OZvCMSn7lU5nB';

class RemoteEnv {
  final String envName;
  final String protocol;
  final String domain;
  final String port;
  final String secret;

  const RemoteEnv(this.envName, this.protocol, this.domain, this.port, this.secret);

  static RemoteEnv _singleton;

  static RemoteEnv get() {
    if (_singleton == null) {
      loadEnv();
    }
    return _singleton;
  }

  static bool isTargetingProd() {
    RemoteEnv env = RemoteEnv.get();
    if (env == null || env == RemoteEnv.PRODUCTION)
      return true;
    else
      return false;
  }

  static Future<RemoteEnv> loadEnv() async {
    String envName = await FlutterKeychain.get(key: 'envName');
    String protocol = await FlutterKeychain.get(key: 'protocol');
    String domain = await FlutterKeychain.get(key: 'domain');
    String port = await FlutterKeychain.get(key: 'port');
    String secret = await FlutterKeychain.get(key: 'secret');

    if (envName == null ||
        protocol == null ||
        domain == null ||
        port == null ||
        secret == null) {
      _singleton = RemoteEnv.PRODUCTION;
    } else {
      _singleton = RemoteEnv(envName, protocol, domain, port, secret);
    }
    return _singleton;
  }

  static void storeEnv(RemoteEnv env) async {
    await FlutterKeychain.put(key: 'envName', value: env.envName);
    await FlutterKeychain.put(key: 'protocol', value: env.protocol);
    await FlutterKeychain.put(key: 'domain', value: env.domain);
    await FlutterKeychain.put(key: 'port', value: env.port);
    await FlutterKeychain.put(key: 'secret', value: env.secret);
    _singleton = env;
  }

  static const RemoteEnv PRODUCTION =
      const RemoteEnv("production", PROTOCOL, DOMAIN, "", SECRET);
  static const RemoteEnv DEBUG =
      const RemoteEnv("debug", PROTOCOL, "staging.$DOMAIN", "80", SECRET);

  /// Example to write other env
  /// static const Env DEBUG_101 = const Env("https", "10.34.231.22", null, "");
}
