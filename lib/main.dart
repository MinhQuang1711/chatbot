import 'package:chatgpt/view/screens/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const SpeechApp());
}

class SpeechApp extends StatelessWidget {
  const SpeechApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
