import 'package:relieve_app/datamodel/chat.dart';

abstract class MessageService {
  Future<List<Chat>> getAllChat(int page, int limit);

  Future<List<Message>> getAllMessage(String chatId, int page, int limit);

  Future<bool> sendChatMessage(String otherUserId, Message message);
}
