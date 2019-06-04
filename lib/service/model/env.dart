import 'package:flutter_keychain/flutter_keychain.dart';

const String PROTOCOL = 'https';
const String DOMAIN = 'relieve.id';
const String SECRET = 'BdQv7AHrFsAb5JMwYN6OZvCMSn7lU5nB';

class Env {
  final String envName;
  final String protocol;
  final String domain;
  final String port;
  final String secret;

  const Env(this.envName, this.protocol, this.domain, this.port, this.secret);

  static Env _singleton;

  static Env get() {
    if (_singleton == null) {
      loadEnv();
    }
    return _singleton;
  }

  static bool isProd() {
    Env env = Env.get();
    if (env == Env.PRODUCTION)
      return true;
    else
      return false;
  }

  static Future<Env> loadEnv() async {
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
      _singleton = Env.PRODUCTION;
    } else {
      _singleton = Env(envName, protocol, domain, port, secret);
    }
    return _singleton;
  }

  static void storeEnv(Env env) async {
    await FlutterKeychain.put(key: 'envName', value: env.envName);
    await FlutterKeychain.put(key: 'protocol', value: env.protocol);
    await FlutterKeychain.put(key: 'domain', value: env.domain);
    await FlutterKeychain.put(key: 'port', value: env.port);
    await FlutterKeychain.put(key: 'secret', value: env.secret);
    _singleton = env;
  }

  static const Env PRODUCTION =
      const Env("production", PROTOCOL, DOMAIN, "", SECRET);
  static const Env DEBUG =
      const Env("debug", PROTOCOL, "staging.$DOMAIN", "80", SECRET);

  /// Example to write other env
  /// static const Env DEBUG_101 = const Env("https", "10.34.231.22", null, "");
}
