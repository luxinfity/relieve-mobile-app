import 'package:flutter/material.dart';
import 'package:relieve_app/datamodel/chat.dart';
import 'package:relieve_app/res/export.dart';
import 'package:relieve_app/service/api/bakau/bakau_provider.dart';
import 'package:relieve_app/service/api/base/api.dart';
import 'package:relieve_app/utils/common_utils.dart';
import 'package:relieve_app/widget/common/relieve_scaffold.dart';

class MessageScreen extends StatefulWidget {
  final Chat chat;

  const MessageScreen(
    this.chat, {
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  TextEditingController _messageInputController = TextEditingController();
  List<Message> messageList = [];

  @override
  Widget build(BuildContext context) {
    return RelieveScaffold(
      hasAppBarScreen: true,
      childs: <Widget>[
        _createCustomAppBar(),
        messageList.isNotEmpty
            ? Expanded(
                child: ListView.builder(
                    itemCount: messageList.length,
                    itemBuilder: (ctx, idx) {
                      if (idx % 2 == 0)
                        return _createRightBubble(messageList[idx]);
                      else
                        return _createLeftBubble(messageList[idx]);
                    }))
            : Expanded(child: Container()),
        Container(height: 1, color: Theme.of(context).dividerColor),
        _createInputText()
      ],
    );
  }

  void sendMessage() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    String content = _messageInputController.text;

    Message message = Message(
        content: content,
        timeSend: DateTime.now().millisecondsSinceEpoch,
        isRead: false);

    bool isSuccess = await Api.get()
        .setProvider(BakauProvider())
        .sendChatMessage(widget.chat.userId, message);

//    if (!isSuccess || !mounted) return;
    setState(() {
      _messageInputController.text = "";
      messageList.add(message);
    });
  }

  Widget _createCustomAppBar() {
    return AppBar(
      leading: _createBackButton(),
      title: Row(
        children: <Widget>[
          CircleAvatar(
            radius: Dimen.x18,
            child: Text('NR'),
          ),
          Container(width: Dimen.x14),
          Text(
            'Nia Ramadani',
            overflow: TextOverflow.ellipsis,
            style: CircularStdFont.bold
                .getStyle(size: Dimen.x16, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _createBackButton() {
    return IconButton(
      padding: EdgeInsets.all(Dimen.x8),
      icon: LocalImage.icBackArrow.toSvg(height: 26, color: Colors.white),
      onPressed: () => defaultBackPressed(context),
    );
  }

  Widget _createInputText() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Dimen.x4,
        horizontal: Dimen.x16,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              child: TextField(
                keyboardType: TextInputType.multiline,
                onChanged: (text) {
                  setState(() {});
                },
                controller: _messageInputController,
                maxLines: null,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Pesan'),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            disabledColor: AppColor.colorEmptyRect,
            color: AppColor.colorPrimary,
            onPressed: _messageInputController.text.isNotEmpty
                ? () => sendMessage()
                : null,
          )
        ],
      ),
    );
  }

  Widget _createRightBubble(Message message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(
              right: Dimen.x16,
              top: Dimen.x4,
              bottom: Dimen.x4,
              left: Dimen.x64),
          padding: const EdgeInsets.all(Dimen.x8),
          decoration: BoxDecoration(
              color: AppColor.colorAccent,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimen.x16),
                  bottomLeft: Radius.circular(Dimen.x16),
                  bottomRight: Radius.circular(Dimen.x16))),
          child: Text(
            message.content,
            style: TextStyle(color: Colors.white),
            maxLines: null,
          ),
        ),
      ],
    );
  }

  Widget _createLeftBubble(Message message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(
              left: Dimen.x16,
              top: Dimen.x4,
              bottom: Dimen.x4,
              right: Dimen.x64),
          padding: const EdgeInsets.all(Dimen.x8),
          decoration: BoxDecoration(
              color: AppColor.colorPrimary,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimen.x16),
                  bottomLeft: Radius.circular(Dimen.x16),
                  bottomRight: Radius.circular(Dimen.x16))),
          child: Text(
            message.content,
            style: TextStyle(color: Colors.white),

            maxLines: null,
          ),
        ),
      ],
    );
  }
}
