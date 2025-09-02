import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui_app/main_app.dart';
import 'package:flutter/material.dart';

void main() {
  CaravaggioUI.initialize(
    primaryColor: const Color(0xFF662D8C),
    secondaryColor: const Color(0xFFED1E79),
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Caravaggio UI',
      theme: CaravaggioUI.instance.themeData,
      home: const HomeScreen(),
    );
  }
}
