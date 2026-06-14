import 'package:caravaggio_ui/src/generics/fonts.dart';
import 'package:caravaggio_ui/src/themes/theme.dart';
import 'package:caravaggio_ui/src/utils/icon_badge_metrics.dart';
import 'package:flutter/material.dart';

/// Visual style for [CTagChip].
enum CTagChipVariant {
  /// Primary tint background for light surfaces.
  normal,

  /// Translucent white background for dark or image overlays.
  overlay,
}

/// Text badge chip shared by [CCarousel], [CTile], and similar components.
class CTagChip extends StatelessWidget {
  const CTagChip({
    super.key,
    required this.label,
    this.variant = CTagChipVariant.normal,
  });

  static const EdgeInsets padding = EdgeInsets.symmetric(horizontal: 10, vertical: 6);

  final String label;
  final CTagChipVariant variant;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor;
    final TextStyle? textStyle;

    switch (variant) {
      case CTagChipVariant.overlay:
        backgroundColor = Colors.white.withValues(alpha: 0.15);
        textStyle = const TextStyle(color: Colors.white);
      case CTagChipVariant.normal:
        backgroundColor = CColors.primaryColor.withValues(alpha: 0.08);
        textStyle = TextStyle(color: CColors.primaryColor);
    }

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: CIconBadgeMetrics.borderRadius,
      ),
      padding: padding,
      child: CText.label(
        label,
        size: TextSize.small,
        style: textStyle,
      ),
    );
  }
}
