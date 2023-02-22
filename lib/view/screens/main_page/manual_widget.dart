import 'package:flutter/material.dart';
import 'package:flutter_application_3/constant.dart';
import 'package:flutter_application_3/define.dart';
class manualWidget extends StatelessWidget {
   manualWidget({super.key,});
  @override
  Widget build(BuildContext context) {
    return 
    Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 30,bottom: 20),
          child: Expanded(child: Text(titleManual))),
        Expanded(
          child: ListView.builder(
            itemCount: listQuestions.length,
            itemBuilder: (context, index) {
              return Container(margin: EdgeInsets.only(left: 120), child: Text(listQuestions[index]));
            },
          ),
        ),
      ],
    );
}
}