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
import 'demo_scaffold_title.dart';

/// Resets the navigation stack to [HomeScreen] with a back-style slide transition.
void navigateToDemoHome(BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(
    PageRouteBuilder<void>(
      pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).chain(
          CurveTween(curve: Curves.easeInOut),
        );
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ),
    (route) => false,
  );
}

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
    final navigator = Navigator.of(context);
    final alreadyOnHome = context.findAncestorWidgetOfExactType<HomeScreen>() != null;

    navigator.pop();

    if (!alreadyOnHome) {
      navigateToDemoHome(navigator.context);
    }
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
              _AppDrawerHeader(onHomePressed: () => _goHome(context)),
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

class _AppDrawerHeader extends StatelessWidget {
  const _AppDrawerHeader({required this.onHomePressed});

  final VoidCallback onHomePressed;

  static const _lightText = TextStyle(color: Colors.white);
  static const _mutedLightText = TextStyle(color: Color(0xD9FFFFFF));

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        gradient: CGradient.primaryToSecondary,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: -72,
            right: -48,
            child: Opacity(
              opacity: 0.16,
              child: Image.asset(
                'assets/pattern_primary_dark.png',
                width: 220,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: -88,
            left: -56,
            child: Opacity(
              opacity: 0.12,
              child: Image.asset(
                'assets/pattern_secondary_dark.png',
                width: 240,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 72,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0),
                    Colors.black.withValues(alpha: 0.14),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onHomePressed,
                      borderRadius: const BorderRadius.all(AppRadius.m),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.94),
                                borderRadius: const BorderRadius.all(AppRadius.m),
                                boxShadow: AppShadow.xs,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.network(
                                  kDemoLogoUrl,
                                  height: 36,
                                  width: 36,
                                  fit: BoxFit.contain,
                                  filterQuality: FilterQuality.medium,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CText.headline(
                                    'Caravaggio UI',
                                    size: TextSize.small,
                                    style: _lightText.copyWith(
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.3,
                                      height: 1.1,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  CText.body(
                                    'Component gallery',
                                    size: TextSize.small,
                                    style: _mutedLightText.copyWith(height: 1.2),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  CButton.outlined(
                    onPressed: onHomePressed,
                    color: Colors.white,
                    fillColor: Colors.white.withValues(alpha: 0.1),
                    icon: const Icon(
                      Icons.home_outlined,
                      color: Colors.white,
                      size: 18,
                    ),
                    child: CText.label(
                      'Back to Home',
                      size: TextSize.small,
                      style: _lightText,
                    ),
                  ).small,
                ],
              ),
            ),
          ),
        ],
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
