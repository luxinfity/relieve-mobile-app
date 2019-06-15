abstract class MessageService {
  void getAllTopic();

  void getAllMessage(String topic);

  void sendChatMessage(String otherUserId, String message);
}
