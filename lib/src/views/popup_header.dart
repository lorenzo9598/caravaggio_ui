import 'package:caravaggio_ui/src/generics/fonts.dart';
import 'package:caravaggio_ui/src/themes/theme.dart';
import 'package:caravaggio_ui/src/utils/app_radius.dart';
import 'package:caravaggio_ui/src/views/icon_badge.dart';
import 'package:flutter/material.dart';

/// Shared header for [CPopup], [CModalBottomSheet], and similar surfaces.
class CPopupHeader extends StatelessWidget {
  const CPopupHeader({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.borderRadius = const BorderRadius.vertical(top: AppRadius.defaultRadius),
    this.backgroundColor,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.iconColor,
    this.iconBackgroundColor,
  });

  static const EdgeInsets padding = EdgeInsets.all(16);
  static const double iconGap = 12;
  static const double titleSubtitleGap = 4;

  final IconData icon;
  final String title;
  final String? subtitle;
  final BorderRadius borderRadius;

  /// Header background. Default: [CColors.primaryColorLight].
  final Color? backgroundColor;

  /// Override for the title [CText] style.
  final TextStyle? titleTextStyle;

  /// Override for the subtitle [CText] style.
  final TextStyle? subtitleTextStyle;

  /// Color of the header icon. Default: [CColors.primaryColor].
  final Color? iconColor;

  /// Background of the icon badge. Default: tinted [iconColor].
  final Color? iconBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? CColors.primaryColorLight,
        borderRadius: borderRadius,
      ),
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CIconBadge(
            icon: icon,
            iconColor: iconColor,
            backgroundColor: iconBackgroundColor,
          ),
          const SizedBox(width: iconGap),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CText.title(title, size: TextSize.medium, style: titleTextStyle),
                if (subtitle != null) ...[
                  const SizedBox(height: titleSubtitleGap),
                  CText.body(subtitle!, size: TextSize.small, style: subtitleTextStyle),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
