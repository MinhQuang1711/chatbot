import 'package:flutter/material.dart';
import 'package:flutter_application_2/view/screens/main_screen.dart';

void main() {
  runApp(const SaoKhue());
}

class SaoKhue extends StatelessWidget {
  const SaoKhue({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}