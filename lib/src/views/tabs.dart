import 'package:caravaggio_ui/src/generics/fonts.dart';
import 'package:caravaggio_ui/src/themes/theme.dart';
import 'package:caravaggio_ui/src/utils/app_radius.dart';
import 'package:caravaggio_ui/src/utils/app_spacing.dart';
import 'package:flutter/material.dart';

/// Describes a single tab label (and optional icon) for [CTabs].
class CTabItem {
  const CTabItem({
    required this.label,
    this.icon,
  });

  /// Tab label shown in the pill bar.
  final String label;

  /// Optional leading icon beside [label].
  final IconData? icon;
}

/// Rounded pill tab bar backed by Material [TabBar] / [TabBarView].
///
/// Provide [tabs] and [children] with the same length, or use [CTabs.fromLabels].
///
/// Pass an optional [controller] to share a [TabController] with other widgets;
/// otherwise [CTabs] creates and owns one internally.
class CTabs extends StatefulWidget {
  CTabs({
    super.key,
    required this.tabs,
    required this.children,
    this.controller,
    this.onTabChanged,
    this.initialIndex = 0,
    this.tabBarHeight = _defaultTabBarHeight,
    this.contentPadding = const EdgeInsets.all(16),
    this.contentHeight,
    this.enableSwipe = false,
  })  : assert(tabs.length == children.length, 'tabs and children must have the same length'),
        assert(tabs.isNotEmpty, 'tabs must not be empty'),
        assert(
          controller == null || controller.length == tabs.length,
          'controller.length must match tabs.length',
        );

  factory CTabs.fromLabels({
    Key? key,
    required List<String> labels,
    required List<Widget> children,
    TabController? controller,
    void Function(int index)? onTabChanged,
    int initialIndex = 0,
    double tabBarHeight = _defaultTabBarHeight,
    EdgeInsets contentPadding = const EdgeInsets.all(16),
    double? contentHeight,
    bool enableSwipe = false,
  }) {
    return CTabs(
      key: key,
      tabs: labels.map((label) => CTabItem(label: label)).toList(),
      controller: controller,
      onTabChanged: onTabChanged,
      initialIndex: initialIndex,
      tabBarHeight: tabBarHeight,
      contentPadding: contentPadding,
      contentHeight: contentHeight,
      enableSwipe: enableSwipe,
      children: children,
    );
  }

  /// Tab descriptors; length must match [children].
  final List<CTabItem> tabs;

  /// One widget per tab panel; length must match [tabs].
  final List<Widget> children;

  /// Optional external [TabController]. When null, one is created internally.
  final TabController? controller;

  /// Called when the selected tab index changes.
  final void Function(int index)? onTabChanged;

  /// Index of the tab selected on first build. Default: `0`.
  final int initialIndex;

  /// Height of each tab in the pill bar. Default: `44`.
  final double tabBarHeight;

  /// Padding applied around each tab panel. Default: `EdgeInsets.all(16)`.
  final EdgeInsets contentPadding;

  /// Fixed height for the tab content area.
  ///
  /// Required when [enableSwipe] is true. When null and [enableSwipe] is false,
  /// the height is derived from the tallest child.
  final double? contentHeight;

  /// When true, tab content can be changed with horizontal swipes.
  ///
  /// Requires [contentHeight] when used inside unbounded vertical layouts.
  final bool enableSwipe;

  static const double _defaultTabBarHeight = 44;

  @override
  State<CTabs> createState() => _CTabsState();
}

class _CTabsState extends State<CTabs> with SingleTickerProviderStateMixin {
  TabController? _internalController;

  TabController get _controller => widget.controller ?? _internalController!;

  @override
  void initState() {
    super.initState();
    _initController();
    _controller.addListener(_handleTabControllerChanged);
  }

  void _initController() {
    if (widget.controller != null) {
      return;
    }
    final maxIndex = widget.tabs.length - 1;
    _internalController = TabController(
      length: widget.tabs.length,
      vsync: this,
      initialIndex: widget.initialIndex.clamp(0, maxIndex),
    );
  }

  void _handleTabControllerChanged() {
    if (_controller.indexIsChanging) {
      return;
    }
    widget.onTabChanged?.call(_controller.index);
  }

  @override
  void didUpdateWidget(covariant CTabs oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != null) {
      if (oldWidget.tabs.length != widget.tabs.length) {
        assert(
          widget.controller!.length == widget.tabs.length,
          'controller.length must match tabs.length',
        );
      }
      return;
    }

    if (oldWidget.tabs.length != widget.tabs.length) {
      _controller.removeListener(_handleTabControllerChanged);
      _internalController?.dispose();
      _internalController = null;
      _initController();
      _controller.addListener(_handleTabControllerChanged);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTabControllerChanged);
    _internalController?.dispose();
    super.dispose();
  }

  ScrollPhysics get _tabViewPhysics => widget.enableSwipe ? const PageScrollPhysics() : const NeverScrollableScrollPhysics();

  List<Widget> get _paddedChildren => [
        for (final child in widget.children)
          Padding(
            padding: widget.contentPadding,
            child: child,
          ),
      ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mutedForeground = theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.65) ?? Colors.grey;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        _CRoundedTabBar(
          controller: _controller,
          tabs: widget.tabs,
          height: widget.tabBarHeight,
          mutedForeground: mutedForeground,
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: const BorderRadius.all(AppRadius.m),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: const BorderRadius.all(AppRadius.m),
              border: Border.all(
                color: CColors.primaryColor.withValues(alpha: 0.12),
              ),
            ),
            child: _buildTabView(),
          ),
        ),
      ],
    );
  }

  Widget _buildTabView() {
    if (widget.enableSwipe) {
      assert(
        widget.contentHeight != null,
        'contentHeight is required when enableSwipe is true',
      );
    }

    final tabBarView = TabBarView(
      controller: _controller,
      physics: _tabViewPhysics,
      children: _paddedChildren,
    );

    final height = widget.contentHeight;
    if (height != null) {
      return SizedBox(height: height, child: tabBarView);
    }

    return _IntrinsicTabBarView(
      controller: _controller,
      physics: _tabViewPhysics,
      children: _paddedChildren,
    );
  }
}

class _CRoundedTabBar extends StatelessWidget {
  const _CRoundedTabBar({
    required this.controller,
    required this.tabs,
    required this.height,
    required this.mutedForeground,
  });

  final TabController controller;
  final List<CTabItem> tabs;
  final double height;
  final Color mutedForeground;

  static const double _barPadding = AppSpacing.xs;
  static const double _tabGap = AppSpacing.xs;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: CColors.primaryColor.withValues(alpha: 0.08),
        borderRadius: const BorderRadius.all(AppRadius.xl),
        border: Border.all(
          color: CColors.primaryColor.withValues(alpha: 0.14),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(_barPadding),
        child: Material(
          color: Colors.transparent,
          child: TabBar(
            controller: controller,
            isScrollable: false,
            tabAlignment: TabAlignment.fill,
            dividerColor: Colors.transparent,
            splashBorderRadius: const BorderRadius.all(AppRadius.xl),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: _tabGap / 2),
            indicator: BoxDecoration(
              color: CColors.primaryColor,
              borderRadius: const BorderRadius.all(AppRadius.xl),
            ),
            labelColor: CColors.onPrimaryColor,
            unselectedLabelColor: mutedForeground,
            labelStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            tabs: [
              for (final item in tabs)
                Tab(
                  height: height,
                  child: _CTabLabel(item: item),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CTabLabel extends StatelessWidget {
  const _CTabLabel({required this.item});

  final CTabItem item;

  @override
  Widget build(BuildContext context) {
    final style = DefaultTextStyle.of(context).style;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (item.icon != null) ...[
          Icon(
            item.icon,
            size: 18,
            color: style.color,
          ),
          const SizedBox(width: 6),
        ],
        Flexible(
          child: CText.label(
            item.label,
            size: TextSize.small,
            style: style,
          ),
        ),
      ],
    );
  }
}

/// Sizes [TabBarView] to the tallest padded child when no explicit height is set.
class _IntrinsicTabBarView extends StatefulWidget {
  const _IntrinsicTabBarView({
    required this.controller,
    required this.physics,
    required this.children,
  });

  final TabController controller;
  final ScrollPhysics physics;
  final List<Widget> children;

  @override
  State<_IntrinsicTabBarView> createState() => _IntrinsicTabBarViewState();
}

class _IntrinsicTabBarViewState extends State<_IntrinsicTabBarView> {
  final GlobalKey _measureKey = GlobalKey();
  double? _height;

  @override
  void didUpdateWidget(covariant _IntrinsicTabBarView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.children.length != widget.children.length) {
      _height = null;
    }
  }

  void _scheduleMeasure() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      final measuredHeight = _measureKey.currentContext?.size?.height;
      if (measuredHeight != null && measuredHeight != _height) {
        setState(() => _height = measuredHeight);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_height == null) {
      _scheduleMeasure();
      return Offstage(
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            key: _measureKey,
            alignment: Alignment.topCenter,
            children: widget.children,
          ),
        ),
      );
    }

    return SizedBox(
      height: _height,
      child: TabBarView(
        controller: widget.controller,
        physics: widget.physics,
        children: widget.children,
      ),
    );
  }
}
