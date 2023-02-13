import 'package:flutter/material.dart';

import '../../model/chat_message_model.dart';

class ChatWidget extends StatelessWidget {
  ChatWidget(
      {required this.type,
      required this.textColor,
      required this.backgroundColor,
      required this.size,
      required this.textMessage,
      super.key});
  var size;
  String? textMessage;
  Color backgroundColor;
  Color textColor;
  ChatMesageType type;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/image/chat-gpt-logo.jpg'),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          width: size * .7,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), color: backgroundColor),
          child: Center(
            child: Text(
              textMessage!,
              style: TextStyle(color: textColor),
            ),
          ),
        )
      ],
    );
  }
}
