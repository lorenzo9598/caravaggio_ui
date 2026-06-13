import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:flutter/material.dart';

/// Scroll distance (px) to fully hide or reveal the title.
const double kCScaffoldTitleHideScrollRange = 56.0;

/// Width of the default back control in the app bar ([IconButton] minimum touch
/// target). The app bar [Row] reserves the leading slot for this width when the
/// default back pill is shown (typically ~[kCScaffoldLeadingWidth]).
const double kCScaffoldLeadingWidth = 48.0;

const double _kScrollFadeDistance = 80.0;

/// Design-system scaffold with gradient background, scroll-linked app bar chrome,
/// and optional scroll-aware title.
///
/// The app bar includes a default back pill (when [showBackButton] is true and
/// [leading] is null) whose background and icon colors interpolate with scroll
/// offset. A top [scrollOverlayColor] gradient fades in while the body scrolls.
///
/// Use [bodyBuilder] (or [CScaffold.topPaddingOf]) so scrollable content clears
/// the overlay app bar. Pass [scrollController] when the body uses its own
/// controller so overlay, title, and back pill stay in sync.
class CScaffold extends StatefulWidget {
  const CScaffold({
    super.key,
    this.body,
    this.bodyBuilder,
    this.leading,
    this.action,
    this.drawer,
    this.scrollController,
    this.title,
    this.titleAlignment = Alignment.centerLeft,
    this.hideTitleOnScroll = true,
    this.showBackButton = true,
    this.backButtonTopBackgroundAlpha = 0.5,
    this.backButtonScrolledBackgroundAlpha = 0.7,
    this.backButtonScrolledBackgroundColor,
    this.backButtonBorder,
    this.backButtonIcon,
    this.backgroundGradient,
    this.backgroundLayers = const [],
    this.scrollOverlayColor,
    this.onBackPressed,
  });

  /// Main content below the overlay app bar.
  ///
  /// Ignored when [bodyBuilder] is set. Otherwise wrapped in top [Padding] using
  /// [CScaffoldState.topPadding].
  final Widget? body;

  /// When set, the scaffold does not wrap the body in a fixed [Padding].
  /// Instead, this builder is called with [topPadding] so you can apply it
  /// to your scrollable (e.g. [ListView]: `ListView(padding: EdgeInsets.only(top: topPadding), ...)`).
  final Widget Function(BuildContext context, double topPadding)? bodyBuilder;

  /// Optional control on the left of the app bar (e.g. drawer menu).
  ///
  /// When null and [showBackButton] is true, the default back pill is shown.
  final Widget? leading;

  /// Optional control pinned to the right of the app bar.
  final Widget? action;

  /// Optional [Scaffold.drawer] content.
  final Widget? drawer;

  /// Optional. If the body is scrollable and uses a custom [ScrollController],
  /// pass it here so the overlay gradient and title can react to scroll offset.
  final ScrollController? scrollController;

  /// Returns the top padding from the nearest [CScaffold] above [context].
  static double? topPaddingOf(BuildContext context) {
    return context.findAncestorStateOfType<CScaffoldState>()?.topPadding;
  }

  /// Widget shown in the app bar area (e.g. page title).
  ///
  /// When [hideTitleOnScroll] is true, fades and slides away on scroll down.
  final Widget? title;

  /// Horizontal and vertical alignment of [title] in the app bar area.
  final Alignment titleAlignment;

  /// When true (default), the [title] fades and slides away on scroll down and
  /// reappears on scroll up. When false, the title stays visible while scrolling.
  final bool hideTitleOnScroll;

  /// When false and [leading] is null, no control is shown on the left of the app bar.
  final bool showBackButton;

  /// Background alpha of the default back pill at scroll offset 0 (white base).
  ///
  /// Defaults to `0.5`.
  final double backButtonTopBackgroundAlpha;

  /// Background alpha of the default back pill when scroll-linked fade completes
  /// ([backButtonScrolledBackgroundColor] base).
  ///
  /// Defaults to `0.7`.
  final double backButtonScrolledBackgroundAlpha;

  /// Background color of the default back pill when scroll-linked fade completes.
  /// Defaults to [CColors.secondaryColor] when null.
  final Color? backButtonScrolledBackgroundColor;

  /// Optional border for the default back pill. When null, no border is drawn.
  final BorderSide? backButtonBorder;

  /// Icon for the default back pill. Defaults to [Icons.arrow_back_ios_new_outlined].
  final IconData? backButtonIcon;

  /// Background gradient behind [backgroundLayers] and body content.
  ///
  /// Defaults to [CGradient.primaryLightToSecondaryLight].
  final Gradient? backgroundGradient;

  /// Optional widgets painted above the gradient and below scrollable content.
  final List<Widget> backgroundLayers;

  /// Tint for the top scroll overlay gradient.
  ///
  /// Shown while the body scrolls; opacity tracks scroll offset. Defaults to
  /// [CColors.secondaryColorLight] when null.
  final Color? scrollOverlayColor;

  /// Called when the default back button is pressed. Defaults to [Navigator.pop].
  final VoidCallback? onBackPressed;

  @override
  State<CScaffold> createState() => CScaffoldState();
}

/// State for [CScaffold]; exposes [topPadding] and [openDrawer].
class CScaffoldState extends State<CScaffold> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ScrollController? _primaryScrollController;
  ScrollController get _effectiveScrollController => widget.scrollController ?? _primaryScrollController!;

  late double _actionBarHeight = 88.0;
  double _lastScrollOffset = 0;
  double _titleVisibility = 1;

  /// Top padding to use for the scrollable (e.g. [ListView.padding]).
  double get topPadding => _actionBarHeight;

  /// Opens [CScaffold.drawer] when one is attached.
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  double get _effectiveTitleVisibility => widget.hideTitleOnScroll ? _titleVisibility : 1.0;

  void _updateTitleVisibility(double offset) {
    if (!widget.hideTitleOnScroll || widget.title == null) return;

    if (offset <= 0) {
      _titleVisibility = 1;
      _lastScrollOffset = 0;
      return;
    }

    final delta = offset - _lastScrollOffset;
    _lastScrollOffset = offset;
    if (delta == 0) return;

    if (delta > 0) {
      _titleVisibility = (_titleVisibility - delta / kCScaffoldTitleHideScrollRange).clamp(0.0, 1.0);
    } else {
      _titleVisibility = (_titleVisibility - delta / kCScaffoldTitleHideScrollRange).clamp(0.0, 1.0);
    }
  }

  void _onScroll() {
    if (_effectiveScrollController.hasClients) {
      _updateTitleVisibility(_effectiveScrollController.offset);
    }
    setState(() {});
  }

  double get _scrollProgress {
    if (!_effectiveScrollController.hasClients) return 0;
    return (_effectiveScrollController.offset / _kScrollFadeDistance).clamp(0.0, 1.0);
  }

  Widget _buildTitle(BuildContext context) {
    return Align(
      alignment: widget.titleAlignment,
      child: IgnorePointer(
        ignoring: _effectiveTitleVisibility < 0.5,
        child: Opacity(
          opacity: widget.title == null ? 0 : _effectiveTitleVisibility,
          child: Transform.translate(
            offset: Offset(0, -10 * (1 - _effectiveTitleVisibility)),
            child: Theme(
              data: Theme.of(context).copyWith(
                textTheme: Theme.of(context).textTheme.apply(
                      bodyColor: CColors.primaryColor,
                    ),
              ),
              child: widget.title ?? const SizedBox.shrink(),
            ),
          ),
        ),
      ),
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (widget.leading != null) {
      return widget.leading;
    }
    if (!widget.showBackButton) {
      return null;
    }
    return _buildDefaultBackButton(context);
  }

  Widget _buildDefaultBackButton(BuildContext context) {
    final scrolledBackgroundColor = widget.backButtonScrolledBackgroundColor ?? CColors.secondaryColor;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: Color.lerp(
          Colors.white.withValues(
            alpha: widget.backButtonTopBackgroundAlpha,
          ),
          scrolledBackgroundColor.withValues(
            alpha: widget.backButtonScrolledBackgroundAlpha,
          ),
          _scrollProgress,
        ),
        border: widget.backButtonBorder == null ? null : Border.fromBorderSide(widget.backButtonBorder!),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton.filled(
        color: Color.lerp(
          CColors.secondaryColor,
          CColors.primaryColor,
          _scrollProgress,
        )!,
        style: IconButton.styleFrom(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        onPressed: widget.onBackPressed ?? () => Navigator.pop(context),
        padding: const EdgeInsets.only(
          left: 8,
          right: 10,
          top: 8,
          bottom: 8,
        ),
        icon: Icon(widget.backButtonIcon ?? Icons.arrow_back_ios_new_outlined),
      ),
    );
  }

  Widget _buildAppBarContent(BuildContext context) {
    final leading = _buildLeading(context);
    final title = _buildTitle(context);
    final trailing = widget.action;

    return Row(
      children: [
        if (leading != null) leading,
        if (leading != null) const SizedBox(width: 12),
        Expanded(child: title),
        (widget.titleAlignment != Alignment.centerRight ? const SizedBox(width: 12) : const SizedBox(width: 0)),
        trailing ?? (widget.titleAlignment != Alignment.centerRight ? const SizedBox(width: kCScaffoldLeadingWidth) : const SizedBox(width: 0)),
      ],
    );
  }

  Widget _wrapWithPrimaryScrollController(Widget child) {
    final controller = _primaryScrollController;
    if (controller == null) return child;
    return PrimaryScrollController(
      controller: controller,
      child: child,
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.scrollController == null) {
      _primaryScrollController = ScrollController();
    }
    _effectiveScrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _actionBarHeight = MediaQuery.of(context).padding.top + 56;
  }

  @override
  void didUpdateWidget(covariant CScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.scrollController != widget.scrollController) {
      (oldWidget.scrollController ?? _primaryScrollController)?.removeListener(_onScroll);
      if (widget.scrollController == null && _primaryScrollController == null) {
        _primaryScrollController = ScrollController();
      }
      _effectiveScrollController.addListener(_onScroll);
    }
  }

  @override
  void dispose() {
    _effectiveScrollController.removeListener(_onScroll);
    _primaryScrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scrollOverlayColor = widget.scrollOverlayColor ?? CColors.secondaryColorLight;

    return Scaffold(
      key: _scaffoldKey,
      drawer: widget.drawer,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: widget.backgroundGradient ?? CGradient.primaryLightToSecondaryLight,
            ),
          ),
          ...widget.backgroundLayers,
          Stack(
            children: [
              _wrapWithPrimaryScrollController(
                widget.bodyBuilder != null
                    ? Builder(
                        builder: (context) => widget.bodyBuilder!(
                          context,
                          topPadding,
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(top: topPadding),
                        child: widget.body,
                      ),
              ),
              if (_effectiveScrollController.hasClients && _effectiveScrollController.offset > 0)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: _actionBarHeight * 1.5,
                  child: IgnorePointer(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            scrollOverlayColor.withValues(alpha: _scrollProgress),
                            scrollOverlayColor.withValues(alpha: 0.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              SafeArea(
                bottom: false,
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  child: _buildAppBarContent(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
