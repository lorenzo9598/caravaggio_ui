import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui_app/pages/demo_pages.dart';
import 'package:caravaggio_ui_app/widgets/demo_scaffold_title.dart';
import 'package:caravaggio_ui_app/widgets/scaffold.dart';
import 'package:caravaggio_ui_app/widgets/section.dart';
import 'package:flutter/material.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      demoPageId: DemoPageId.tabs,
      title: demoScaffoldTitleFor(DemoPageId.tabs),
      bodyBuilder: (context, topPadding) {
        return Sections(
          padding: EdgeInsets.only(top: topPadding + 12, left: 16, right: 16, bottom: 12),
          sections: [
            Section(
              title: 'With icons',
              icon: Icons.tab_outlined,
              items: [
                (
                  'CTabs',
                  CTabs(
                    initialIndex: _selectedTab,
                    onTabChanged: (index) => setState(() => _selectedTab = index),
                    tabs: const [
                      CTabItem(label: 'Overview', icon: Icons.dashboard_outlined),
                      CTabItem(label: 'Stats', icon: Icons.bar_chart_outlined),
                      CTabItem(label: 'Details', icon: Icons.info_outline),
                    ],
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CText.title('Overview'),
                          const SizedBox(height: 8),
                          CText.body(
                            'Material TabBar / TabBarView with a rounded pill indicator.',
                            size: TextSize.small,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CCircularIndicator.single(
                            value: CircularValue(currentValue: 72, maxValue: 100),
                            label: 'Completion',
                          ),
                          const SizedBox(height: 8),
                          CText.body('Tab content can host any widget.', size: TextSize.small),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CText.label('Active tab: $_selectedTab', size: TextSize.small),
                          const SizedBox(height: 8),
                          CText.body(
                            'Use onTabChanged to react to selection.',
                            size: TextSize.small,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Section(
              title: 'Labels only',
              icon: Icons.label_outline,
              items: [
                (
                  'CTabs.fromLabels',
                  CTabs.fromLabels(
                    labels: const ['First', 'Second', 'Third'],
                    children: [
                      Center(child: CText.body('First tab content')),
                      Center(child: CText.body('Second tab content')),
                      Center(child: CText.body('Third tab content')),
                    ],
                  ),
                ),
              ],
            ),
            Section(
              title: 'Swipeable',
              icon: Icons.swipe_outlined,
              items: [
                (
                  'enableSwipe',
                  CTabs.fromLabels(
                    enableSwipe: true,
                    contentHeight: 120,
                    labels: const ['Alpha', 'Beta', 'Gamma'],
                    children: [
                      Center(child: CText.body('Swipe between tabs')),
                      Center(child: CText.body('Native TabBarView physics')),
                      Center(child: CText.body('Indicator animates with selection')),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
