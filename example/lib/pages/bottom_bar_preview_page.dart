import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui_app/widgets/demo_scaffold_title.dart';
import 'package:caravaggio_ui_app/widgets/scaffold.dart';
import 'package:flutter/material.dart';

class BottomBarPreviewPage extends StatefulWidget {
  const BottomBarPreviewPage({super.key});

  @override
  State<BottomBarPreviewPage> createState() => _BottomBarPreviewPageState();
}

class _BottomBarPreviewPageState extends State<BottomBarPreviewPage> {
  int _index = 0;

  static const _labels = ['Home', 'Cerca', 'Profilo'];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: demoScaffoldTitle('Bottom bar'),
      showAppDrawer: false,
      bottomBar: CBottomBar(
        currentIndex: _index,
        onTap: (index) => setState(() => _index = index),
        items: const [
          CBottomBarItem(
              icon: Icons.home_outlined,
              selectedIcon: Icons.home,
              label: 'Home'),
          CBottomBarItem(icon: Icons.search, label: 'Cerca'),
          CBottomBarItem(
              icon: Icons.person_outline,
              selectedIcon: Icons.person,
              label: 'Profilo'),
        ],
      ),
      bodyBuilder: (context, topPadding) {
        return ListView(
          padding: EdgeInsets.only(
              top: topPadding + 24, left: 16, right: 16, bottom: 24),
          children: [
            CText.body('Voce selezionata: ${_labels[_index]}'),
          ],
        );
      },
    );
  }
}
