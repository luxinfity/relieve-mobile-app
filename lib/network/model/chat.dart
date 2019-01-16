import 'package:flutter/foundation.dart';

class Chat {
  final String userId;
  final String lastMessage;
  final int lastTimeSend;
  final bool isRead;

  const Chat({
    @required this.userId,
    @required this.lastMessage,
    @required this.lastTimeSend,
    @required this.isRead,
  });
}
