import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui_app/main_app.dart';
import 'package:caravaggio_ui_app/preview_scroll_behavior.dart';
import 'package:caravaggio_ui_app/webview_device_info.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize date formatting
  await initializeDateFormatting('en', null);

  CaravaggioUI.initialize(
    primaryColor: const Color(0xFF6F513B),
    secondaryColor: const Color(0xFF405055),
    // primaryColor: Colors.blue,
    // secondaryColor: Colors.yellow,
    // primaryColor: const Color(0xFF662D8C),
    // secondaryColor: const Color(0xFFED1E79),
  );

  if (isPreviewMode) {
    runApp(DevicePreview(
      builder: (context) => const MainApp(),
      backgroundColor: Colors.white,
      defaultDevice: webviewDeviceInfo,
      isToolbarVisible: false,
    ));
    return;
  }

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
      locale: DevicePreview.locale(context),
      title: 'Caravaggio UI',
      theme: CUI.themeData,
      scrollBehavior: isPreviewMode ? const PreviewScrollBehavior() : const MaterialScrollBehavior(),
      builder: (context, child) {
        Widget built = CToast(child: DevicePreview.appBuilder(context, child));
        if (isPreviewMode) {
          built = AbsorbWheelScroll(child: built);
        }
        return built;
      },
      home: const HomeScreen(),
    );
  }
}
