import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

abstract class ChatConst {
  static const String MEMBERS = "members";
}

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

  factory Chat.fromMap(Map<String, dynamic> data) {
    // TODO: parse chat data
    return Chat(
      isRead: false,
      userId: '1111',
      lastMessage: 'aldada',
      lastTimeSend: 100,
    );
  }
}

class ChatMeta {
  final DocumentSnapshot lastRetrievedDoc;
  final int currentPage;
  final int totalData;

  const ChatMeta({this.lastRetrievedDoc, this.currentPage, this.totalData});
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
