import 'package:flutter/material.dart';
import 'package:flutter_application_3/define.dart';
import 'package:flutter_application_3/model/message_model.dart';


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
  chatMessageType ?type;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: 5,top: 5),
          child: CircleAvatar(
            backgroundImage:
            AssetImage(
              type==chatMessageType.user
              ?logoUser:logoSaoKhue
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          width: 270,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), color: backgroundColor),
          child: Center(
            child: Text(
              textMessage!,
              style: TextStyle(color: textColor,fontSize: 14),
            ),
          ),
        )
      ],
    );
  }
}
