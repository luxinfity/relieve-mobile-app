import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:relieve_app/service/base/message_service.dart';

class CloudMessageHelper implements MessageService {
  static final CloudMessageHelper _instance = CloudMessageHelper._internal();

  static CloudMessageHelper get() => _instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  CloudMessageHelper._internal();

  @override
  void sendChatMessage(String otherUserId, String message) {

  }

  @override
  void getAllMessage(String topic) {

  }

  @override
  void getAllTopic() {

  }

}
