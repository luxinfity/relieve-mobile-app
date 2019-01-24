import 'package:flutter/material.dart';

import '../../res/res.dart';
import '../../service/model/chat.dart';

class ChatItem extends StatelessWidget {
  final Chat chat;

  const ChatItem({
    Key key,
    @required this.chat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimen.x16,
            vertical: Dimen.x8,
          ),
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(chat.isRead ? 0 : 2),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColor.colorPrimary,
                      width: 2,
                    )),
                child: CircleAvatar(
                  radius: Dimen.x28,
                  child: Text('JE'),
                ),
              ),
              Container(width: Dimen.x21),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'Nia ramadhani',
                            overflow: TextOverflow.ellipsis,
                            style: CircularStdFont.bold.getStyle(
                              size: Dimen.x16,
                            ),
                          ),
                        ),
                        Text(
                          '12:00',
                          style: CircularStdFont.book.getStyle(
                            size: Dimen.x14,
                            color: AppColor.colorTextGrey,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: Dimen.x32,
                      child: Text(
                        'Sayang sudah makan?',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: CircularStdFont.book.getStyle(
                          size: Dimen.x14,
                          color: AppColor.colorTextGrey,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Divider()
      ],
    );
  }
}
