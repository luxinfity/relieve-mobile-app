import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:relieve_app/service/base/message_service.dart';

class CloudMessageHelper implements MessageService {
  static final CloudMessageHelper _instance = CloudMessageHelper._internal();

  static CloudMessageHelper get() => _instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  factory CloudMessageHelper() {
    return _instance;
  }

  CloudMessageHelper._internal();

  @override
  void sendFamilyRequest(String otherUserToken, Map requestData) {}

  @override
  void sendChatMessage(String otherUserToken, String message) {}
}
