import 'dart:async';

import 'package:caravaggio_ui/src/generics/fonts.dart';
import 'package:caravaggio_ui/src/themes/theme.dart';
import 'package:caravaggio_ui/src/utils/app_colors.dart';
import 'package:caravaggio_ui/src/utils/app_radius.dart';
import 'package:caravaggio_ui/src/utils/app_shadow.dart';
import 'package:caravaggio_ui/src/views/icon_badge.dart';
import 'package:flutter/material.dart';

/// Semantic style for [CToast] messages.
enum CToastVariant {
  error,
  success,
  warning,
  info,
}

/// Screen edge where [CToast.showMessage] anchors the toast.
enum CToastPosition {
  top,
  bottom,
}

/// Host for Caravaggio toast overlays. Wrap the app root (e.g. via [MaterialApp.builder]).
class CToast extends StatefulWidget {
  const CToast({super.key, required this.child});

  final Widget child;

  /// Returns a scope tied to [context] for showing toasts.
  ///
  /// Overlay lookup uses this [context] (not [CToast]'s own), so toasts work
  /// when [CToast] wraps the app via [MaterialApp.builder] above the navigator.
  static CToastScope of(BuildContext context) {
    final state = context.findAncestorStateOfType<CToastState>();
    assert(
      state != null,
      'CToast not found in context. Wrap your app with CToast, for example:\n'
      'MaterialApp(builder: (context, child) => CToast(child: child ?? const SizedBox.shrink()))',
    );
    return CToastScope._(state!, context);
  }

  @override
  State<CToast> createState() => CToastState();
}

/// Handle returned by [CToast.of] to show toasts from a specific subtree.
class CToastScope {
  const CToastScope._(this._state, this._context);

  final CToastState _state;
  final BuildContext _context;

  /// Shows a toast overlay. Replaces any message currently visible.
  void showMessage({
    required String title,
    String? subtitle,
    CToastVariant variant = CToastVariant.info,
    IconData? icon,
    Duration duration = const Duration(seconds: 1),
    CToastPosition position = CToastPosition.top,
    bool dismissOnSwipe = true,
  }) {
    _state._showMessage(
      overlayContext: _context,
      title: title,
      subtitle: subtitle,
      variant: variant,
      icon: icon,
      duration: duration,
      position: position,
      dismissOnSwipe: dismissOnSwipe,
    );
  }
}

class CToastState extends State<CToast> {
  OverlayEntry? _activeEntry;
  Timer? _activeTimer;
  Future<void> Function()? _activeAnimatedDismiss;

  void _showMessage({
    required BuildContext overlayContext,
    required String title,
    String? subtitle,
    CToastVariant variant = CToastVariant.info,
    IconData? icon,
    Duration duration = const Duration(seconds: 1),
    CToastPosition position = CToastPosition.top,
    bool dismissOnSwipe = true,
  }) {
    _dismissActive();

    final overlay = Overlay.maybeOf(overlayContext, rootOverlay: true);
    assert(
      overlay != null,
      'No Overlay found for the context passed to CToast.of. '
      'Ensure CToast.of is called from a context below a Navigator (e.g. a page or dialog route).',
    );
    if (overlay == null) return;

    late OverlayEntry entry;
    final slideFrom = position == CToastPosition.top ? const Offset(0, -1) : const Offset(0, 1);

    entry = OverlayEntry(
      builder: (overlayContext) => _CToastOverlay(
        position: position,
        slideFrom: slideFrom,
        dismissOnSwipe: dismissOnSwipe,
        onDismiss: () => _removeMessage(entry),
        onReady: (dismiss) => _activeAnimatedDismiss = dismiss,
        child: _CToastMessage(
          variant: variant,
          title: title,
          subtitle: subtitle,
          icon: icon,
          onDismiss: () => _requestDismiss(entry),
        ),
      ),
    );

    _activeEntry = entry;
    overlay.insert(entry);

    if (duration > Duration.zero) {
      _activeTimer = Timer(duration, () => _requestDismiss(entry));
    }
  }

  void _dismissActive() {
    final entry = _activeEntry;
    if (entry != null) {
      _requestDismiss(entry);
    }
  }

  void _requestDismiss(OverlayEntry entry) {
    _activeTimer?.cancel();
    _activeTimer = null;

    if (_activeEntry != entry) return;

    final dismiss = _activeAnimatedDismiss;
    if (dismiss != null) {
      dismiss();
      return;
    }

    _removeMessage(entry);
  }

  void _removeMessage(OverlayEntry entry) {
    if (_activeEntry != entry) return;

    entry.remove();
    _activeEntry = null;
    _activeAnimatedDismiss = null;
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class _CToastMessage extends StatelessWidget {
  const _CToastMessage({
    required this.variant,
    required this.title,
    this.subtitle,
    this.icon,
    this.onDismiss,
  });

  static const BorderRadius _borderRadius = BorderRadius.all(AppRadius.m);
  static const EdgeInsets _padding = EdgeInsets.all(12);
  static const double _accentWidth = 4;
  static const double _iconGap = 12;
  static const double _titleSubtitleGap = 2;

  final CToastVariant variant;
  final String title;
  final String? subtitle;
  final IconData? icon;
  final VoidCallback? onDismiss;

  Color get _accentColor => switch (variant) {
        CToastVariant.error => AppColors.errorColor,
        CToastVariant.success => AppColors.successColor,
        CToastVariant.warning => AppColors.warningColor,
        CToastVariant.info => AppColors.infoColor,
      };

  IconData get _defaultIcon => switch (variant) {
        CToastVariant.error => Icons.error_outline,
        CToastVariant.success => Icons.check_circle_outline,
        CToastVariant.warning => Icons.warning_amber_outlined,
        CToastVariant.info => Icons.info_outline,
      };

  @override
  Widget build(BuildContext context) {
    final accent = _accentColor;

    return Material(
      color: Colors.transparent,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: _borderRadius,
          border: Border.all(color: accent.withValues(alpha: 0.24)),
          boxShadow: AppShadow.sm,
        ),
        child: ClipRRect(
          borderRadius: _borderRadius,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ColoredBox(
                  color: accent,
                  child: const SizedBox(width: _accentWidth),
                ),
                Expanded(
                  child: Padding(
                    padding: _padding,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CIconBadge(
                          icon: icon ?? _defaultIcon,
                          iconColor: accent,
                          backgroundColor: accent.withValues(alpha: 0.1),
                        ),
                        const SizedBox(width: _iconGap),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CText.title(title, size: TextSize.small),
                              if (subtitle != null) ...[
                                const SizedBox(height: _titleSubtitleGap),
                                CText.body(
                                  subtitle!,
                                  size: TextSize.small,
                                  style: TextStyle(
                                    color: CColors.primary.shade600,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        if (onDismiss != null)
                          IconButton(
                            visualDensity: VisualDensity.compact,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 32,
                              minHeight: 32,
                            ),
                            icon: Icon(
                              Icons.close,
                              size: 18,
                              color: CColors.primary.shade400,
                            ),
                            onPressed: onDismiss,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CToastOverlay extends StatefulWidget {
  const _CToastOverlay({
    required this.position,
    required this.slideFrom,
    required this.dismissOnSwipe,
    required this.onDismiss,
    required this.onReady,
    required this.child,
  });

  final CToastPosition position;
  final Offset slideFrom;
  final bool dismissOnSwipe;
  final VoidCallback onDismiss;
  final void Function(Future<void> Function() dismiss) onReady;
  final Widget child;

  @override
  State<_CToastOverlay> createState() => _CToastOverlayState();
}

class _CToastOverlayState extends State<_CToastOverlay> with SingleTickerProviderStateMixin {
  static const Duration _animationDuration = Duration(milliseconds: 280);
  static const EdgeInsets _margin = EdgeInsets.symmetric(horizontal: 16);

  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;

  double _dragOffset = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );
    _slideAnimation = Tween<Offset>(
      begin: widget.slideFrom,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
    widget.onReady(_animateOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _animateOut() async {
    if (!mounted) return;
    await _controller.reverse();
    if (mounted) {
      widget.onDismiss();
    }
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    if (!widget.dismissOnSwipe) return;

    final delta = details.primaryDelta ?? 0;
    final isTop = widget.position == CToastPosition.top;
    final dismissDirection = isTop ? -1.0 : 1.0;

    if (delta * dismissDirection > 0) {
      setState(() => _dragOffset += delta);
    }
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if (!widget.dismissOnSwipe) return;

    final velocity = details.primaryVelocity ?? 0;
    final isTop = widget.position == CToastPosition.top;
    const threshold = 48.0;
    final shouldDismiss = _dragOffset.abs() > threshold || (isTop && velocity < -400) || (!isTop && velocity > 400);

    if (shouldDismiss) {
      _animateOut();
    } else {
      setState(() => _dragOffset = 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final top = widget.position == CToastPosition.top;
    final alignment = top ? Alignment.topCenter : Alignment.bottomCenter;
    final padding = top ? EdgeInsets.only(top: MediaQuery.paddingOf(context).top + 8) : EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom + 8);

    return Positioned.fill(
      child: IgnorePointer(
        ignoring: false,
        child: Material(
          color: Colors.transparent,
          child: Align(
            alignment: alignment,
            child: Padding(
              padding: padding.add(_margin),
              child: SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: GestureDetector(
                    onVerticalDragUpdate: _onVerticalDragUpdate,
                    onVerticalDragEnd: _onVerticalDragEnd,
                    child: Transform.translate(
                      offset: Offset(0, _dragOffset),
                      child: widget.child,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
