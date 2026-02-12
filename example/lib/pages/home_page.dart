import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:flutter/material.dart';

import 'buttons_page.dart';
import 'colors_page.dart';
import 'fields_page.dart';
import 'indicators_page.dart';
import 'loaders_page.dart';
import 'login_page.dart';
import 'pickers_page.dart';
import 'tables_page.dart';
import 'texts_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: _AppDrawer(),
      body: _HomePage(),
    );
  }
}

class _AppDrawer extends StatelessWidget {
  const _AppDrawer();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Theme(
      data: theme.copyWith(
        dividerTheme: DividerThemeData(
          color: Colors.grey[300] ?? Colors.grey,
          thickness: 1.0,
        ),
      ),
      child: Drawer(
        child: Container(
          color: theme.scaffoldBackgroundColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: CGradient.primaryToSecondary,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 84,
                        width: 84,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white.withValues(alpha: 0.25),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Image(
                            image: NetworkImage(
                              'https://raw.githubusercontent.com/lorenzo9598/caravaggio_ui/refs/heads/main/assets-for-api-docs/logo.png',
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      CText.headline(
                        'Caravaggio UI',
                        size: TextSize.medium,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
                child: Text(
                  'Basics',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.6,
                    color: Colors.grey,
                  ),
                ),
              ),
              _DrawerTile(
                icon: Icons.palette_outlined,
                title: 'Colors',
                onTap: () => _goTo(context, const ColorsPage()),
              ),
              _DrawerTile(
                icon: Icons.text_fields,
                title: 'Texts',
                onTap: () => _goTo(context, const TextsPage()),
              ),
              _DrawerTile(
                icon: Icons.smart_button_outlined,
                title: 'Buttons',
                onTap: () => _goTo(context, const ButtonsPage()),
              ),
              _DrawerTile(
                icon: Icons.input,
                title: 'Fields',
                onTap: () => _goTo(context, const FieldsPage()),
              ),
              _DrawerTile(
                icon: Icons.table_chart_outlined,
                title: 'Tables',
                onTap: () => _goTo(context, const TablesPage()),
              ),
              _DrawerTile(
                icon: Icons.donut_large_outlined,
                title: 'Indicators',
                onTap: () => _goTo(context, const IndicatorsPage()),
              ),
              _DrawerTile(
                icon: Icons.hourglass_empty,
                title: 'Loaders',
                onTap: () => _goTo(context, const LoadersPage()),
              ),
              _DrawerTile(
                icon: Icons.calendar_today,
                title: 'Pickers',
                onTap: () => _goTo(context, const PickersPage()),
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
                child: Text(
                  'Views',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.6,
                    color: Colors.grey,
                  ),
                ),
              ),
              _DrawerTile(
                icon: Icons.login,
                title: 'Login',
                onTap: () => _goTo(context, const LoginPage()),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  void _goTo(BuildContext context, Widget page) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  const _DrawerTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(8),
        child: Icon(
          icon,
          size: 20,
          color: theme.colorScheme.primary,
        ),
      ),
      title: CText.body(
        title,
        size: TextSize.medium,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      dense: true,
      onTap: onTap,
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                CColors.primaryColor,
                CColors.secondaryColor,
                CColors.primaryColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(24.0),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
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
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 16 + 56,
          left: 16,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(8),
            child: IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.menu),
            ),
          ),
        ),
      ],
    );
  }
}
