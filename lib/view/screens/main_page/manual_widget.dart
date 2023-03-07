import 'package:flutter/material.dart';
import 'package:flutter_application_3/constants/color.dart';
import 'package:flutter_application_3/constants/list.dart';
import 'package:flutter_application_3/define.dart';
class manualWidget extends StatelessWidget {
   manualWidget({ required this.size, super.key,});
   double size;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Expanded(
          child: Text(titleManual)),
        Expanded(
          flex: 18,
          child: ListView.builder(
            itemCount: listQuestions.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:  EdgeInsets.symmetric(horizontal: size/5 ),
                child: Text("- ${listQuestions[index]}"),
              );
            },
          ),
        ),
      ],
    );
  }
}