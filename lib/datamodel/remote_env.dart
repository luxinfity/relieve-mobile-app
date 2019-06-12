import 'package:relieve_app/utils/preference_utils.dart';

const String PROTOCOL = 'https';
const String DOMAIN = 'relieve.id';
const String SECRET = 'BdQv7AHrFsAb5JMwYN6OZvCMSn7lU5nB';

class RemoteEnv {
  final String envName;
  final String protocol;
  final String domain;
  final String port;
  final String secret;

  const RemoteEnv(
      this.envName, this.protocol, this.domain, this.port, this.secret);

  static RemoteEnv _singleton;

  static RemoteEnv get() {
    if (_singleton == null) {
      loadEnv();
    }
    return _singleton;
  }

  static bool isTargetingProd() {
    RemoteEnv env = RemoteEnv.get();
    return (env == null || env == RemoteEnv.PRODUCTION);
  }

  static Future<RemoteEnv> loadEnv() async {
    String envName =
        (await PreferenceUtils.get().storage.read(key: 'envName')) ?? '';
    String protocol =
        (await PreferenceUtils.get().storage.read(key: 'protocol')) ?? '';
    String domain =
        (await PreferenceUtils.get().storage.read(key: 'domain')) ?? '';
    String port = (await PreferenceUtils.get().storage.read(key: 'port')) ?? '';
    String secret =
        (await PreferenceUtils.get().storage.read(key: 'secret')) ?? '';

    if (envName.isEmpty ||
        protocol.isEmpty ||
        domain.isEmpty ||
        port.isEmpty ||
        secret.isEmpty) {
      _singleton = RemoteEnv.PRODUCTION;
    } else {
      _singleton = RemoteEnv(envName, protocol, domain, port, secret);
    }
    return _singleton;
  }

  /// After storing new env don't forget to call `Api.reset()`
  static void storeEnv(RemoteEnv env) async {
    await PreferenceUtils.get()
        .storage
        .write(key: 'envName', value: env.envName);
    await PreferenceUtils.get()
        .storage
        .write(key: 'protocol', value: env.protocol);
    await PreferenceUtils.get().storage.write(key: 'domain', value: env.domain);
    await PreferenceUtils.get().storage.write(key: 'port', value: env.port);
    await PreferenceUtils.get().storage.write(key: 'secret', value: env.secret);
    _singleton = env;
  }

  static const RemoteEnv PRODUCTION =
      const RemoteEnv("production", PROTOCOL, DOMAIN, "", SECRET);
  static const RemoteEnv DEBUG =
      const RemoteEnv("debug", PROTOCOL, "staging.$DOMAIN", "80", SECRET);

  /// Example to write other env
  /// static const Env DEBUG_101 = const Env("https", "10.34.231.22", null, "");
}
