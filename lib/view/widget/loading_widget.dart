import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
class LoadingWidget extends StatelessWidget {
   LoadingWidget({required this.colorLoading,required this.isListening,super.key});
   bool isListening;
  Color colorLoading;

  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      child:Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colorLoading
      ),
    ),
    animate: isListening,
    glowColor: colorLoading,
    duration: Duration(milliseconds: 2000),
    showTwoGlows: true,
    repeat: true,
    endRadius: 20,
    repeatPauseDuration: Duration(milliseconds: 100),
    );
  }
}