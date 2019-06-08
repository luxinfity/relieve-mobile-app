import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:relieve_app/utils/common_utils.dart';

abstract class PreferenceUtils {
  static const _LOG_IN_KEY = "login_stat";

  static final storage = FlutterSecureStorage();

  /// Clear all pref on user phone.
  /// don't forget to call this method on logout action
  static void clearData() {
    storage.deleteAll();
  }

  static Future<String> uid() async {
    if (await isLogin()) {
      final user = await FirebaseAuth.instance.currentUser();
      return user.uid;
    } else {
      return null;
    }
  }

  static Future<bool> isLogin() async {
    String data = (await storage.read(key: _LOG_IN_KEY)) ?? '0';
    return data == '1';
  }

  static void setLogin(bool status) async {
    return await storage.write(key: _LOG_IN_KEY, value: status ? '1' : '0');
  }

  static Future<bool> isGoogleLogin() async {
    final user = await FirebaseAuth.instance.currentUser();
    if (user == null) return false;

    for (UserInfo info in user.providerData) {
      debugLog(PreferenceUtils).info(info.providerId);
      if (info.providerId == "google.com") return true;
    }

    return false;
  }
}
