import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui_app/main_app.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize date formatting
  await initializeDateFormatting('en', null);

  CaravaggioUI.initialize(
    primaryColor: const Color(0xFF6F513B), secondaryColor: const Color(0xFF405055),
    // primaryColor: Colors.blue,
    // secondaryColor: Colors.yellow,
    // primaryColor: const Color(0xFF662D8C),
    // secondaryColor: const Color(0xFFED1E79),
  );

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    CaravaggioUI.instance.colorsListenable.addListener(_onColorsChanged);
  }

  @override
  void dispose() {
    CaravaggioUI.instance.colorsListenable.removeListener(_onColorsChanged);
    super.dispose();
  }

  void _onColorsChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Caravaggio UI',
      theme: CUI.themeData,
      builder: (context, child) => CToast(child: child ?? const SizedBox.shrink()),
      home: const HomeScreen(),
    );
  }
}
