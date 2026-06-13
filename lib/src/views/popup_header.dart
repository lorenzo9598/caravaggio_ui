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
    this.borderRadius = const BorderRadius.vertical(top: AppRadius.l),
  });

  static const EdgeInsets padding = EdgeInsets.all(16);
  static const double iconGap = 12;
  static const double titleSubtitleGap = 4;

  final IconData icon;
  final String title;
  final String? subtitle;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CColors.primaryColorLight,
        borderRadius: borderRadius,
      ),
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CIconBadge(icon: icon),
          const SizedBox(width: iconGap),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CText.title(title, size: TextSize.medium),
                if (subtitle != null) ...[
                  const SizedBox(height: titleSubtitleGap),
                  CText.body(subtitle!, size: TextSize.small),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
