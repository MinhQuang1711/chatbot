import 'package:flutter/material.dart';

import '../../model/chat_message_model.dart';

class ChatWidget extends StatelessWidget {
  ChatWidget(
      {required this.type,
      required this.textColor,
      required this.backgroundColor,
      required this.textMessage,
      super.key});
  String? textMessage;
  Color backgroundColor;
  Color textColor;
  ChatMesageType type;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Container(
        //   margin: EdgeInsets.only(left: 5,top: 5),
        //   child: CircleAvatar(
        //     backgroundImage: AssetImage(type==ChatMesageType.user?'asset/image/user.jpg':'asset/image/chat-gpt-logo.jpg'),
        //   ),
        // ),
        Container(
          margin: EdgeInsets.all(10),
          width: 270,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), color: backgroundColor),
          child: Center(
            child: Text(
              textMessage!,
              style: TextStyle(color: textColor,fontSize: 16),
            ),
          ),
        )
      ],
    );
  }
}
