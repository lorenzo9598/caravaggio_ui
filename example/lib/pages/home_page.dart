import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui_app/pages/demo_pages.dart';
import 'package:caravaggio_ui_app/widgets/scaffold.dart';
import 'package:caravaggio_ui_app/widgets/theme_color_picker.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      showBackgroundLayers: true,
      body: _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  void _openFirstTourPage(BuildContext context) {
    final firstPageId = DemoPages.navigableOrder.first;
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => DemoPages.pageFor(firstPageId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(24.0),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(flex: 1),
            const SizedBox(
              height: 220,
              width: 220,
              child: Image(
                image: NetworkImage(
                  'https://raw.githubusercontent.com/lorenzo9598/caravaggio_ui/refs/heads/main/assets-for-api-docs/logo.png',
                ),
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            CText.body(
              'Discover and play with stylish UI components – open the menu to start your design adventure!',
              size: TextSize.medium,
              textAlign: TextAlign.center,
            ).primaryDark,
            const SizedBox(height: 20),
            const ThemeColorPicker(),
            const SizedBox(height: 20),
            CColorsBuilder(
              builder: (context) => CButton.elevated(
                gradient: CGradient.primaryToSecondary,
                foregroundColor: Colors.white,
                onPressed: () => _openFirstTourPage(context),
                suffixIcon: const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 22,
                ),
                child: CText.label(
                  'Get Started',
                  size: TextSize.large,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
