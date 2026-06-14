import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui_app/pages/complex_form_page.dart';
import 'package:caravaggio_ui_app/pages/loading_page.dart';
import 'package:caravaggio_ui_app/pages/login_page.dart';
import 'package:caravaggio_ui_app/pages/statistics_page.dart';
import 'package:caravaggio_ui_app/pages/views_dialogs_page.dart';
import 'package:caravaggio_ui_app/pages/views_discover_page.dart';
import 'package:caravaggio_ui_app/pages/views_tabs_page.dart';
import 'package:caravaggio_ui_app/widgets/demo_scaffold_title.dart';
import 'package:caravaggio_ui_app/widgets/scaffold.dart';
import 'package:caravaggio_ui_app/widgets/theme_color_picker.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showBackgroundLayers: true,
      title: demoScaffoldColorsTitle(),
      titleAlignment: Alignment.center,
      hideTitleOnScroll: false,
      body: const _HomePage(),
    );
  }
}

class _HomeViewEntry {
  const _HomeViewEntry({
    required this.title,
    required this.description,
    required this.image,
    required this.page,
  });

  final String title;
  final String description;
  final ImageProvider image;
  final Widget page;
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  static const _description = 'Discover and play with stylish UI components — open the menu anytime to jump between demos.';

  static const double _horizontalPadding = 20;
  static const double _carouselCardWidth = 260;
  static const double _carouselAspectRatio = 4 / 3;

  static final List<_HomeViewEntry> _views = [
    const _HomeViewEntry(
      title: 'Loading',
      description: 'Splash screens and loading states.',
      image: NetworkImage(
        'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=600&h=450&fit=crop',
      ),
      page: LoadingPage(),
    ),
    const _HomeViewEntry(
      title: 'Discover',
      description: 'Experience cards with detail sheets.',
      image: NetworkImage(
        'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=600&h=450&fit=crop',
      ),
      page: ViewsDiscoverPage(),
    ),
    const _HomeViewEntry(
      title: 'Statistics',
      description: 'Charts and KPI dashboards.',
      image: NetworkImage(
        'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=600&h=450&fit=crop',
      ),
      page: StatisticsPage(),
    ),
    const _HomeViewEntry(
      title: 'Tabs',
      description: 'Tabbed layouts and segmented content.',
      image: NetworkImage(
        'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=600&h=450&fit=crop',
      ),
      page: ViewsTabsPage(),
    ),
    const _HomeViewEntry(
      title: 'Dialogs',
      description: 'Modals, sheets, and popup flows.',
      image: NetworkImage(
        'https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=600&h=450&fit=crop',
      ),
      page: ViewsDialogsPage(),
    ),
    const _HomeViewEntry(
      title: 'Book event',
      description: 'Multi-step form with validation.',
      image: NetworkImage(
        'https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=600&h=450&fit=crop',
      ),
      page: ComplexFormPage(),
    ),
    const _HomeViewEntry(
      title: 'Login',
      description: 'Authentication screen layout.',
      image: NetworkImage(
        'https://images.unsplash.com/photo-1563013544-824ae1b704d3?w=600&h=450&fit=crop',
      ),
      page: LoginPage(),
    ),
  ];

  void _openDrawer(BuildContext context) {
    context.findAncestorStateOfType<CustomScaffoldState>()?.openDrawer();
  }

  void _openView(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.textTheme.bodySmall?.color?.withValues(alpha: 0.72);
    const carouselHeight = _carouselCardWidth / _carouselAspectRatio;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(_horizontalPadding, 8, _horizontalPadding, 0),
            child: _HomeHeroCard(
              description: _description,
              mutedColor: muted,
              onExplore: () => _openDrawer(context),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
            child: ThemeColorPicker(compact: true),
          ),
          const SizedBox(height: 36),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
            child: _HomeSectionHeader(
              icon: Icons.view_carousel_outlined,
              title: 'Views',
              subtitle: 'Full-screen layouts you can open and remix.',
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: carouselHeight,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
              clipBehavior: Clip.none,
              itemCount: _views.length,
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                final view = _views[index];
                return CCarousel.overlaySimple(
                  width: _carouselCardWidth,
                  aspectRatio: _carouselAspectRatio,
                  image: view.image,
                  title: view.title,
                  description: view.description,
                  onTap: () => _openView(context, view.page),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeHeroCard extends StatelessWidget {
  const _HomeHeroCard({
    required this.description,
    required this.mutedColor,
    required this.onExplore,
  });

  final String description;
  final Color? mutedColor;
  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.all(AppRadius.l),
        border: Border.all(
          color: CColors.primaryColor.withValues(alpha: 0.14),
        ),
        boxShadow: AppShadow.xs,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CText.headline(
            'Your design playground',
            size: TextSize.small,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              letterSpacing: -0.3,
              height: 1.15,
            ),
          ).primary,
          const SizedBox(height: 10),
          CText.body(
            description,
            size: TextSize.small,
            style: TextStyle(color: mutedColor, height: 1.45),
          ),
          const SizedBox(height: 22),
          CColorsBuilder(
            builder: (context) => CButton.elevated(
              gradient: CGradient.primaryToSecondary,
              foregroundColor: Colors.white,
              onPressed: onExplore,
              suffixIcon: const Icon(
                Icons.menu_rounded,
                color: Colors.white,
                size: 20,
              ),
              child: CText.label(
                'Explore components',
                size: TextSize.medium,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeSectionHeader extends StatelessWidget {
  const _HomeSectionHeader({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.72);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CIconBadge(icon: icon),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CText.title(title, size: TextSize.medium),
              const SizedBox(height: 4),
              CText.body(
                subtitle,
                size: TextSize.small,
                style: TextStyle(color: muted, height: 1.35),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
