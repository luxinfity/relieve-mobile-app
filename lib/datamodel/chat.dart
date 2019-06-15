import 'package:flutter/foundation.dart';

class Chat {
  final String userId;
  final String lastMessage;
  final int lastTimeSend;
  final int totalMessage;
  final bool isRead;

  const Chat({
    @required this.userId,
    @required this.lastMessage,
    @required this.lastTimeSend,
    @required this.isRead,
    this.totalMessage,
  });
}

class Message {
  final String messageId;
  final String content;
  final int timeSend;
  final bool isRead;

  const Message({
    @required this.content,
    @required this.timeSend,
    @required this.isRead,
    this.messageId,
  });
}
