import 'package:flutter/material.dart';
import 'package:flutter_application_3/constants/list.dart';
import 'package:flutter_application_3/define.dart';
import 'package:flutter_application_3/view/widget/loading_widget.dart';

class Loading extends StatelessWidget {
   Loading({required this.isListening, super.key});
   bool isListening;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: 
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: listColor.length,
                  itemBuilder: (context, index) 
                  =>LoadingWidget(
                    colorLoading: listColor[index],
                    isListening: isListening
                  )
                ),
              ),
            Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: titleWaiting,
            )
          )
        ],
      ),      
    );
  }
}