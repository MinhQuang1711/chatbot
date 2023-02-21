import 'package:flutter/material.dart';
import 'package:flutter_application_3/constant.dart';
class UserManual extends StatelessWidget {
  const UserManual({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Text("Đây là một số câu hỏi tôi có thể trả lời: ")),
        Expanded(child: ListView.builder(
          itemCount: listQuestions.length,
          itemBuilder: (context,index){
            Text(listQuestions[index]);
        }))
      ],
    );
  }
}