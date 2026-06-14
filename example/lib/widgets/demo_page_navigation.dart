import 'dart:ui' show ImageFilter;

import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui_app/pages/demo_pages.dart';
import 'package:caravaggio_ui_app/pages/page_constants.dart';
import 'package:flutter/material.dart';

/// Fixed prev/next bar for demo pages. Use [wrap] around scrollable body content
/// and add [bottomInset] to scroll padding so content is not hidden behind the bar.
class DemoPageNavigation extends StatelessWidget {
  const DemoPageNavigation({
    super.key,
    required this.pageId,
  });

  final DemoPageId pageId;

  static const double _horizontalPadding = 16;
  static const double _verticalPadding = 10;
  static const double _buttonBlockHeight = 66;
  static const double _buttonGap = 10;

  /// Fixed prev/next bar height excluding the device safe-area bottom inset.
  static const double kDemoNavBarHeight = _verticalPadding * 2 + _buttonBlockHeight;

  /// Total space to reserve below scrollable content ([kDemoNavBarHeight] + safe area).
  static double bottomInset(BuildContext context) {
    return kDemoNavBarHeight + MediaQuery.paddingOf(context).bottom;
  }

  /// Scroll padding for demo pages with a fixed bottom nav bar.
  static EdgeInsets scrollPadding(
    BuildContext context, {
    double top = 0,
    double left = _horizontalPadding,
    double right = _horizontalPadding,
    double extraBottom = _verticalPadding,
  }) {
    return EdgeInsets.only(
      top: top,
      left: left,
      right: right,
      bottom: extraBottom + bottomInset(context),
    );
  }

  /// Wraps [child] in a [Stack] with this navigation bar pinned to the bottom.
  static Widget wrap({
    required BuildContext context,
    required DemoPageId pageId,
    required Widget child,
  }) {
    return Stack(
      fit: StackFit.expand,
      children: [
        child,
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: DemoPageNavigation(pageId: pageId),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final previousId = DemoPages.previous(pageId);
    final nextId = DemoPages.next(pageId);
    final hasPrevious = previousId != null;
    final hasNext = nextId != null;

    return _DemoNavBarChrome(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          _horizontalPadding,
          _verticalPadding,
          _horizontalPadding,
          _verticalPadding,
        ),
        child: Row(
          children: [
            hasPrevious
                ? Expanded(
                    child: _PreviousNavButton(
                      destination: previousId,
                      onPressed: () => DemoPages.navigateTo(
                        context,
                        previousId,
                        direction: DemoPageDirection.back,
                      ),
                    ),
                  )
                : const Spacer(),
            const SizedBox(width: _buttonGap),
            hasNext
                ? Expanded(
                    child: _NextNavButton(
                      destination: nextId,
                      onPressed: () => DemoPages.navigateTo(context, nextId, direction: DemoPageDirection.forward),
                    ),
                  )
                : const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _PreviousNavButton extends StatelessWidget {
  const _PreviousNavButton({
    required this.destination,
    required this.onPressed,
  });

  final DemoPageId destination;
  final VoidCallback onPressed;

  static const Icon _chevron = Icon(Icons.chevron_left, size: 22);

  @override
  Widget build(BuildContext context) {
    return CButton.outlined(
      onPressed: onPressed,
      elevation: 1,
      color: CColors.primaryColor.withValues(alpha: 0.7),
      fillColor: Colors.white.withValues(alpha: 0.9),
      icon: _chevron,
      iconAlignment: CButtonIconAlignment.spaceBetween,
      hint: 'Previous',
      hintSize: CButtonHintSize.medium,
      child: CText.label(destination.displayTitle, size: TextSize.large),
    ).large;
  }
}

class _NextNavButton extends StatelessWidget {
  const _NextNavButton({
    required this.destination,
    required this.onPressed,
  });

  final DemoPageId destination;
  final VoidCallback onPressed;

  static const Icon _chevron = Icon(Icons.chevron_right, size: 22);

  @override
  Widget build(BuildContext context) {
    return CButton.elevated(
      onPressed: onPressed,
      gradient: demoGradient,
      foregroundColor: Colors.white,
      elevation: 3,
      suffixIcon: _chevron,
      iconAlignment: CButtonIconAlignment.spaceBetween,
      hint: 'Next',
      hintSize: CButtonHintSize.medium,
      child: CText.label(destination.displayTitle, size: TextSize.large),
    ).large;
  }
}

/// Frosted surface aligned with [CScaffold] gradient chrome.
class _DemoNavBarChrome extends StatelessWidget {
  const _DemoNavBarChrome({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: SafeArea(
        top: false,
        child: child,
      ),
    );
  }
}

/// Set by [CustomScaffold] when [CustomScaffold.demoPageId] is provided.
class DemoNavScope extends InheritedWidget {
  const DemoNavScope({
    super.key,
    required this.pageId,
    required super.child,
  });

  final DemoPageId pageId;

  static DemoPageId? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DemoNavScope>()?.pageId;
  }

  @override
  bool updateShouldNotify(DemoNavScope oldWidget) => pageId != oldWidget.pageId;
}
