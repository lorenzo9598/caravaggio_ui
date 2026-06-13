import 'package:caravaggio_ui/src/themes/theme.dart';
import 'package:caravaggio_ui/src/utils/icon_badge_metrics.dart';
import 'package:flutter/material.dart';

/// Rounded icon container with primary tint background.
class CIconBadge extends StatelessWidget {
  const CIconBadge({
    super.key,
    required this.icon,
    this.backgroundColor,
    this.iconColor,
  });

  final IconData icon;
  final Color? backgroundColor;
  final Color? iconColor;

  static const double iconSize = CIconBadgeMetrics.iconSize;
  static const EdgeInsets padding = CIconBadgeMetrics.padding;
  static final BorderRadius borderRadius = CIconBadgeMetrics.borderRadius;

  @override
  Widget build(BuildContext context) {
    final Color tint = iconColor ?? CColors.primaryColor;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? tint.withValues(alpha: 0.08),
        borderRadius: borderRadius,
      ),
      padding: padding,
      child: Icon(
        icon,
        size: iconSize,
        color: tint,
      ),
    );
  }
}
