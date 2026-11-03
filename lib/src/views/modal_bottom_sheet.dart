import 'package:caravaggio_ui/src/utils/app_radius.dart';
import 'package:caravaggio_ui/src/views/popup.dart';
import 'package:caravaggio_ui/src/views/popup_header.dart';
import 'package:flutter/material.dart';

/// Caravaggio-styled modal bottom sheet with icon header and optional actions.
///
/// Prefer [showCModalBottomSheet] to present this widget with
/// [showModalBottomSheet].
class CModalBottomSheet extends StatelessWidget {
  const CModalBottomSheet({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.body,
    this.actions,
    this.style,
  });

  static const BorderRadius _borderRadius = BorderRadius.vertical(top: AppRadius.defaultRadius);
  static const EdgeInsets _bodyPadding = EdgeInsets.fromLTRB(16, 16, 16, 0);
  static const EdgeInsets _footerPadding = EdgeInsets.all(16);

  /// Header icon passed to [CPopupHeader].
  final IconData icon;

  /// Primary header text.
  final String title;

  /// Optional secondary header text.
  final String? subtitle;

  /// Main sheet content below the header.
  final Widget body;

  /// Optional footer buttons rendered by [CPopupActionsRow].
  final List<CPopupAction>? actions;

  /// Optional visual overrides shared with [CPopup]. `null` keeps theme defaults.
  final CPopupStyle? style;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Material(
        color: style?.backgroundColor ?? Theme.of(context).colorScheme.surface,
        borderRadius: _borderRadius,
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CPopupHeader(
              icon: icon,
              title: title,
              subtitle: subtitle,
              borderRadius: _borderRadius,
              backgroundColor: style?.headerColor,
              titleTextStyle: style?.titleTextStyle,
              subtitleTextStyle: style?.subtitleTextStyle,
              iconColor: style?.iconColor,
              iconBackgroundColor: style?.iconBackgroundColor,
            ),
            Padding(padding: _bodyPadding, child: body),
            if (actions != null && actions!.isNotEmpty)
              Padding(
                padding: _footerPadding,
                child: CPopupActionsRow(actions: actions!),
              ),
          ],
        ),
      ),
    );
  }
}

/// Shows a [CModalBottomSheet] via [showModalBottomSheet] and returns when
/// dismissed.
///
/// Uses a transparent scrim background and `isScrollControlled: true` so tall
/// bodies and keyboard insets are handled correctly.
Future<T?> showCModalBottomSheet<T>({
  required BuildContext context,
  required IconData icon,
  required String title,
  String? subtitle,
  required Widget body,
  List<CPopupAction>? actions,
  bool isDismissible = true,
  bool enableDrag = true,
  CPopupStyle? style,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) => CModalBottomSheet(
      icon: icon,
      title: title,
      subtitle: subtitle,
      body: body,
      actions: actions,
      style: style,
    ),
  );
}
