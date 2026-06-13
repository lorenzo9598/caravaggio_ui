import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui_app/pages/demo_pages.dart';
import 'package:caravaggio_ui_app/widgets/app_drawer.dart';
import 'package:caravaggio_ui_app/widgets/demo_page_navigation.dart';
import 'package:caravaggio_ui_app/widgets/drawer_menu_action.dart';
import 'package:flutter/material.dart';

/// Example-app scaffold: [CScaffold] with demo pattern assets and animated overlays.
class CustomScaffold extends StatefulWidget {
  const CustomScaffold({
    super.key,
    this.body,
    this.bodyBuilder,
    this.action,
    this.drawer,
    this.showAppDrawer = true,
    this.scrollController,
    this.title,
    this.titleAlignment = Alignment.centerLeft,
    this.hideTitleOnScroll = true,
    this.showBackButton = true,
    this.backButtonTopBackgroundAlpha = 0.8,
    this.backButtonScrolledBackgroundAlpha = 0.7,
    this.backButtonScrolledBackgroundColor,
    this.backButtonBorder,
    this.backButtonIcon,
    this.backgroundGradient,
    this.scrollOverlayColor,
    this.onBackPressed,
    this.demoPageId,
    this.showBackgroundLayers = false,
  });

  /// When set, pins [DemoPageNavigation] to the bottom and exposes [DemoNavScope].
  final DemoPageId? demoPageId;

  final Widget? body;
  final Widget Function(BuildContext context, double topPadding)? bodyBuilder;
  final Widget? action;
  final Widget? drawer;

  /// When true (default), attaches [AppDrawer] and a drawer menu icon on the left.
  /// Ignored when [drawer] is set explicitly.
  final bool showAppDrawer;

  /// When false, no default back pill is shown unless [showAppDrawer] supplies [leading].
  final bool showBackButton;

  final ScrollController? scrollController;
  final Widget? title;
  final Alignment titleAlignment;
  final bool hideTitleOnScroll;

  /// White back pill opacity at scroll offset 0. Default: `0.8` in this example wrapper.
  final double backButtonTopBackgroundAlpha;

  /// Opacity of the scrolled back pill background. Default: `0.7`.
  final double backButtonScrolledBackgroundAlpha;

  /// Scrolled back pill background tint. When null, [CScaffold] uses [CColors.secondaryColor].
  final Color? backButtonScrolledBackgroundColor;

  final BorderSide? backButtonBorder;
  final IconData? backButtonIcon;

  /// When null, uses the example-app default (primary/secondary shade50, top-to-bottom).
  final Gradient? backgroundGradient;

  /// Top scroll-fade overlay tint. When null, [CScaffold] uses [CColors.secondaryColorLight].
  final Color? scrollOverlayColor;

  /// Override for the default back pill. When null, [Navigator.pop] is used.
  final VoidCallback? onBackPressed;

  final bool showBackgroundLayers;

  /// Returns the top padding from the nearest [CustomScaffold] / [CScaffold].
  static double? topPaddingOf(BuildContext context) => CScaffold.topPaddingOf(context);

  @override
  State<CustomScaffold> createState() => CustomScaffoldState();
}

class CustomScaffoldState extends State<CustomScaffold> with TickerProviderStateMixin {
  final GlobalKey<CScaffoldState> _scaffoldKey = GlobalKey<CScaffoldState>();

  late final AnimationController _fadeController;
  late final AnimationController _primaryController;
  late final AnimationController _secondaryController;
  late final Animation<double> _fade;
  late final Animation<Offset> _primaryFloat;
  late final Animation<Offset> _secondaryFloat;

  void openDrawer() => _scaffoldKey.currentState?.openDrawer();

  double get topPadding => _scaffoldKey.currentState?.topPadding ?? 88.0;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2300),
    )..repeat(reverse: true);

    _fade = Tween<double>(begin: 0.5, end: 1.0).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    ));

    _primaryController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);

    _secondaryController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);

    _primaryFloat = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(10, -5),
    ).animate(CurvedAnimation(
      parent: _primaryController,
      curve: Curves.easeInOut,
    ));

    _secondaryFloat = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-15, 20),
    ).animate(CurvedAnimation(
      parent: _secondaryController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _primaryController.dispose();
    _secondaryController.dispose();
    super.dispose();
  }

  Widget? get _effectiveDrawer {
    if (widget.drawer != null) {
      return widget.drawer;
    }
    if (widget.showAppDrawer) {
      return const AppDrawer();
    }
    return null;
  }

  Widget? _buildLeading() {
    if (_effectiveDrawer == null) {
      return null;
    }
    return DrawerMenuAction(onPressed: openDrawer);
  }

  Widget _wrapDemoNav(BuildContext context, Widget body) {
    final pageId = widget.demoPageId;
    if (pageId == null) {
      return body;
    }
    return DemoNavScope(
      pageId: pageId,
      child: DemoPageNavigation.wrap(
        context: context,
        pageId: pageId,
        child: body,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CScaffold(
      key: _scaffoldKey,
      body: widget.body != null ? _wrapDemoNav(context, widget.body!) : null,
      bodyBuilder: widget.bodyBuilder != null ? (context, topPadding) => _wrapDemoNav(context, widget.bodyBuilder!(context, topPadding)) : null,
      leading: _buildLeading(),
      action: widget.action,
      drawer: _effectiveDrawer,
      scrollController: widget.scrollController,
      title: widget.title,
      titleAlignment: widget.titleAlignment,
      hideTitleOnScroll: widget.hideTitleOnScroll,
      showBackButton: widget.showBackButton,
      backButtonTopBackgroundAlpha: widget.backButtonTopBackgroundAlpha,
      backButtonScrolledBackgroundAlpha: widget.backButtonScrolledBackgroundAlpha,
      backButtonScrolledBackgroundColor: widget.backButtonScrolledBackgroundColor,
      backButtonBorder: widget.backButtonBorder,
      backButtonIcon: widget.backButtonIcon,
      scrollOverlayColor: widget.scrollOverlayColor,
      onBackPressed: widget.onBackPressed,
      backgroundGradient: widget.backgroundGradient ??
          LinearGradient(
            colors: [
              CColors.primary.shade50,
              CColors.secondary.shade50,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
      backgroundLayers: widget.showBackgroundLayers
          ? [
              Positioned(
                bottom: -300,
                right: -200,
                child: AnimatedBuilder(
                  animation: Listenable.merge([_fadeController, _primaryController]),
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fade.value,
                      child: Transform.translate(
                        offset: _primaryFloat.value * 3,
                        child: child,
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/pattern_primary.png',
                    height: 800,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: -500,
                left: -300,
                child: AnimatedBuilder(
                  animation: Listenable.merge([_fadeController, _secondaryController]),
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fade.value,
                      child: Transform.translate(
                        offset: _secondaryFloat.value * 1.5,
                        child: child,
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/pattern_secondary.png',
                    height: 800,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ]
          : [],
    );
  }
}
