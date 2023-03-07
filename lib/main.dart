import 'package:flutter/material.dart';
import 'package:flutter_application_3/view/screens/main_page/main_page.dart';
import 'package:speech_to_text/speech_to_text.dart';

void main() {

  runApp(const Chatbot());
}

class Chatbot extends StatelessWidget {
  const Chatbot({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}