import 'package:flutter/material.dart';
import 'package:relieve_app/res/export.dart';
import 'package:relieve_app/utils/common_utils.dart';
import 'package:relieve_app/widget/common/relieve_scaffold.dart';

class MessageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  bool hasMessage = false;
  TextEditingController _messageInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return RelieveScaffold(
      hasAppBarScreen: true,
      childs: <Widget>[
        _createCustomAppBar(),
        Expanded(child: ListView()),
        Container(height: 1, color: Theme.of(context).dividerColor),
        _createInputText()
      ],
    );
  }

  void sendMessage() {
    print(_messageInputController.text);
    _messageInputController.text = "";
    FocusScope.of(context).requestFocus(new FocusNode());
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
                  setState(() {
                    hasMessage = text.isNotEmpty;
                  });
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
            onPressed: hasMessage ? () => sendMessage() : null,
          )
        ],
      ),
    );
  }
}
