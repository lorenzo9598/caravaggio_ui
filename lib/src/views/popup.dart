import 'package:caravaggio_ui/src/forms/buttons/button.dart';
import 'package:caravaggio_ui/src/generics/fonts.dart';
import 'package:caravaggio_ui/src/utils/app_radius.dart';
import 'package:caravaggio_ui/src/views/popup_header.dart';
import 'package:flutter/material.dart';

/// Visual style for [CPopupAction] buttons.
enum CPopupActionStyle {
  /// Filled [CButton.elevated].
  elevated,

  /// Bordered [CButton.outlined].
  outlined,
}

/// Describes a footer action shown as a [CButton].
///
/// [CPopupActionsRow] pops the current route before invoking [onPressed].
class CPopupAction {
  const CPopupAction({
    required this.label,
    required this.onPressed,
    this.style = CPopupActionStyle.elevated,
  });

  /// Button label.
  final String label;

  /// Callback after the popup or sheet route is dismissed.
  final VoidCallback onPressed;

  /// Visual style mapped to [CButton.elevated] or [CButton.outlined].
  final CPopupActionStyle style;
}

/// Horizontal row of [CPopupAction] buttons that dismiss the current route.
class CPopupActionsRow extends StatelessWidget {
  const CPopupActionsRow({
    super.key,
    required this.actions,
  });

  static const double _actionGap = 8;

  final List<CPopupAction> actions;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < actions.length; i++) ...[
          if (i > 0) const SizedBox(width: _actionGap),
          Expanded(child: _buildActionButton(context, actions[i])),
        ],
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, CPopupAction action) {
    void onPressed() {
      Navigator.of(context).pop();
      action.onPressed();
    }

    final child = CText.label(action.label);

    return switch (action.style) {
      CPopupActionStyle.elevated => CButton.elevated(
          onPressed: onPressed,
          child: child,
        ),
      CPopupActionStyle.outlined => CButton.outlined(
          onPressed: onPressed,
          child: child,
        ),
    };
  }
}

/// Caravaggio-styled modal popup with icon header and action buttons.
///
/// Prefer [showCPopup] to present this widget inside a [Dialog].
class CPopup extends StatelessWidget {
  const CPopup({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.body,
    required this.actions,
    this.elevation = 8,
  });

  static const BorderRadius _borderRadius = BorderRadius.all(AppRadius.l);
  static const EdgeInsets _bodyPadding = EdgeInsets.fromLTRB(16, 16, 16, 0);
  static const EdgeInsets _footerPadding = EdgeInsets.all(16);

  /// Header icon passed to [CPopupHeader].
  final IconData icon;

  /// Primary header text.
  final String title;

  /// Optional secondary header text.
  final String? subtitle;

  /// Optional content between header and footer actions.
  final Widget? body;

  /// Footer buttons rendered by [CPopupActionsRow].
  final List<CPopupAction> actions;

  /// [Dialog] elevation. Default: `8`.
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: elevation,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: const RoundedRectangleBorder(borderRadius: _borderRadius),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CPopupHeader(
            icon: icon,
            title: title,
            subtitle: subtitle,
            borderRadius: const BorderRadius.vertical(top: AppRadius.l),
          ),
          if (body != null) Padding(padding: _bodyPadding, child: body),
          Padding(
            padding: _footerPadding,
            child: CPopupActionsRow(actions: actions),
          ),
        ],
      ),
    );
  }
}

/// Shows a [CPopup] inside [showDialog] and returns when it is dismissed.
///
/// Each [CPopupAction] dismisses the dialog before running its callback.
Future<T?> showCPopup<T>({
  required BuildContext context,
  required IconData icon,
  required String title,
  String? subtitle,
  Widget? body,
  required List<CPopupAction> actions,
  bool barrierDismissible = true,
  double elevation = 8,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (dialogContext) => CPopup(
      icon: icon,
      title: title,
      subtitle: subtitle,
      body: body,
      actions: actions,
      elevation: elevation,
    ),
  );
}
