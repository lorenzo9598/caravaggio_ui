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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Caravaggio UI'),
      ),
      drawer: const _AppDrawer(),
      body: const _HomePage(),
    );
  }
}

class _AppDrawer extends StatelessWidget {
  const _AppDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Caravaggio UI',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(
              'Basics',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
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
            padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(
              'Views',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          _DrawerTile(
            icon: Icons.login,
            title: 'Login',
            onTap: () => _goTo(context, const LoginPage()),
          ),
        ],
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
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CText.display('Caravaggio UI', size: TextSize.medium),
            const SizedBox(height: 16),
            CText.body(
              'Use the menu to explore Basics and Views.',
              size: TextSize.medium,
            ).secondary,
          ],
        ),
      ),
    );
  }
}
