abstract class MessageService {
  void sendChatMessage(String otherUserToken, String message);

  void sendFamilyRequest(String otherUserToken, Map requestData);
}
