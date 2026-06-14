import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:flutter/material.dart';

import '../pages/carousel_page.dart';
import '../pages/tiles_page.dart';
import '../pages/home_page.dart';
import '../pages/buttons_page.dart';
import '../pages/colors_page.dart';
import '../pages/complex_form_page.dart';
import '../pages/fields_page.dart';
import '../pages/indicators_page.dart';
import '../pages/loaders_page.dart';
import '../pages/login_page.dart';
import '../pages/loading_page.dart';
import '../pages/messages_page.dart';
import '../pages/modal_bottom_sheet_page.dart';
import '../pages/pickers_page.dart';
import '../pages/popup_page.dart';
import '../pages/scaffold_page.dart';
import '../pages/statistics_page.dart';
import '../pages/tables_page.dart';
import '../pages/tabs_page.dart';
import '../pages/texts_page.dart';
import '../pages/views_dialogs_page.dart';
import '../pages/views_discover_page.dart';
import '../pages/views_tabs_page.dart';
import '../pages/wrapper_page.dart';

/// Navigation drawer listing all demo pages (Basics, Advanced, Views).
class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  // Persisted across drawer open/close (widget is recreated each time).
  static bool _basicsExpanded = true;
  static bool _advancedExpanded = false;
  static bool _viewsExpanded = false;

  void _goTo(BuildContext context, Widget page) {
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  void _goHome(BuildContext context) {
    Navigator.pop(context);
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const HomeScreen()),
      (route) => false,
    );
  }

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
                  gradient: CGradient.primaryLightToSecondaryLight,
                ),
                padding: EdgeInsets.zero,
                child: Stack(
                  children: [
                    Positioned(
                      top: -400,
                      left: -150,
                      width: 400,
                      child: Image.asset(
                        'assets/pattern_secondary_dark.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: -300,
                      right: -120,
                      width: 400,
                      child: Image.asset(
                        'assets/pattern_primary_dark.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        children: [
                          const Expanded(
                            child: Center(
                              child: Image(
                                image: NetworkImage(
                                  'https://raw.githubusercontent.com/lorenzo9598/caravaggio_ui/refs/heads/main/assets-for-api-docs/logo.png',
                                ),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          CButton.outlined(
                            onPressed: () => _goHome(context),
                            color: Colors.white,
                            fillColor: Colors.white.withValues(alpha: 0.15),
                            icon: const Icon(
                              Icons.home_outlined,
                              color: Colors.white,
                              size: 18,
                            ),
                            child: CText.label(
                              'Back to Home',
                              size: TextSize.small,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ).small,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _DrawerExpandableSection(
                title: 'Basics',
                expanded: _basicsExpanded,
                onExpansionChanged: (expanded) => setState(() => _basicsExpanded = expanded),
                children: [
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
                    icon: Icons.hourglass_empty,
                    title: 'Loaders',
                    onTap: () => _goTo(context, const LoadersPage()),
                  ),
                  _DrawerTile(
                    icon: Icons.calendar_today,
                    title: 'Pickers',
                    onTap: () => _goTo(context, const PickersPage()),
                  ),
                  _DrawerTile(
                    icon: Icons.donut_large_outlined,
                    title: 'Indicators',
                    onTap: () => _goTo(context, const IndicatorsPage()),
                  ),
                  _DrawerTile(
                    icon: Icons.table_chart_outlined,
                    title: 'Tables',
                    onTap: () => _goTo(context, const TablesPage()),
                  ),
                  _DrawerTile(
                    icon: Icons.tab_outlined,
                    title: 'Tabs',
                    onTap: () => _goTo(context, const TabsPage()),
                  ),
                  _DrawerTile(
                    icon: Icons.notifications_outlined,
                    title: 'Messages',
                    onTap: () => _goTo(context, const MessagesPage()),
                  ),
                ],
              ),
              const Divider(),
              _DrawerExpandableSection(
                title: 'Advanced',
                expanded: _advancedExpanded,
                onExpansionChanged: (expanded) => setState(() => _advancedExpanded = expanded),
                children: [
                  _DrawerTile(
                    icon: Icons.view_quilt_outlined,
                    title: 'Scaffold',
                    onTap: () => _goTo(context, const ScaffoldPage()),
                  ),
                  _DrawerTile(
                    icon: Icons.layers_outlined,
                    title: 'Wrapper',
                    onTap: () => _goTo(context, const WrapperPage()),
                  ),
                  _DrawerTile(
                    icon: Icons.open_in_new_outlined,
                    title: 'Popups',
                    onTap: () => _goTo(context, const PopupPage()),
                  ),
                  _DrawerTile(
                    icon: Icons.vertical_align_top_outlined,
                    title: 'Modal Bottom Sheet',
                    onTap: () => _goTo(context, const ModalBottomSheetPage()),
                  ),
                  _DrawerTile(
                    icon: Icons.view_carousel_outlined,
                    title: 'Carousel',
                    onTap: () => _goTo(context, const CarouselPage()),
                  ),
                  _DrawerTile(
                    icon: Icons.view_list_outlined,
                    title: 'Tiles',
                    onTap: () => _goTo(context, const TilesPage()),
                  ),
                ],
              ),
              const Divider(),
              _DrawerExpandableSection(
                title: 'Views',
                expanded: _viewsExpanded,
                onExpansionChanged: (expanded) => setState(() => _viewsExpanded = expanded),
                children: [
                  _DrawerTile(
                    icon: Icons.hourglass_top_outlined,
                    title: 'Loading',
                    onTap: () => _goTo(context, const LoadingPage()),
                  ),
                  _DrawerTile(
                    icon: Icons.explore_outlined,
                    title: 'Discover',
                    onTap: () => _goTo(context, const ViewsDiscoverPage()),
                  ),
                  _DrawerTile(
                    icon: Icons.insights_outlined,
                    title: 'Statistics',
                    onTap: () => _goTo(context, const StatisticsPage()),
                  ),
                  _DrawerTile(
                    icon: Icons.tab_outlined,
                    title: 'Tabs',
                    onTap: () => _goTo(context, const ViewsTabsPage()),
                  ),
                  _DrawerTile(
                    icon: Icons.forum_outlined,
                    title: 'Dialogs',
                    onTap: () => _goTo(context, const ViewsDialogsPage()),
                  ),
                  _DrawerTile(
                    icon: Icons.edit_note_outlined,
                    title: 'Book event',
                    onTap: () => _goTo(context, const ComplexFormPage()),
                  ),
                  _DrawerTile(
                    icon: Icons.login,
                    title: 'Login',
                    onTap: () => _goTo(context, const LoginPage()),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerExpandableSection extends StatelessWidget {
  const _DrawerExpandableSection({
    required this.title,
    required this.expanded,
    required this.onExpansionChanged,
    required this.children,
  });

  final String title;
  final bool expanded;
  final ValueChanged<bool> onExpansionChanged;
  final List<Widget> children;

  static const _headerStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.6,
    color: Colors.grey,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: () => onExpansionChanged(!expanded),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 12, 4),
            child: Row(
              children: [
                Expanded(
                  child: Text(title, style: _headerStyle),
                ),
                Icon(
                  expanded ? Icons.expand_less : Icons.expand_more,
                  size: 20,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          child: expanded
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: children,
                )
              : const SizedBox(width: double.infinity),
        ),
      ],
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: CIconBadge(icon: icon),
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
