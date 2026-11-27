import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:flutter/material.dart';

/// Horizontal and vertical inset shared by text fields and dropdowns.
///
/// Vertical inset keeps a single-line field at a comfortable touch height.
const EdgeInsets kCFieldContentPadding = EdgeInsets.symmetric(
  horizontal: AppSpacing.xl,
  vertical: 14,
);

/// A widget that displays a label above a field (with optional icon and required indicator).
class FieldLabel extends StatelessWidget {
  const FieldLabel({
    super.key,
    required this.decoration,
    required this.style,
  });

  /// The decoration properties for the label.
  final CFieldDecoration decoration;

  /// The style properties for the label.
  final CFieldStyle style;

  @override
  Widget build(BuildContext context) {
    if (decoration.labelType == FieldLabelType.inline) {
      return const SizedBox.shrink();
    }

    // Check if we have either labelText or label
    final hasLabel = decoration.labelText != null || decoration.label != null;
    if (!hasLabel) {
      return const SizedBox.shrink();
    }

    Widget labelWidget;
    if (decoration.label != null) {
      // Use the custom label widget
      labelWidget = decoration.label!;
    } else {
      // Use the labelText with CText
      labelWidget = CText.label(
        decoration.labelText!,
        size: TextSize.small,
        style: TextStyle(
          color: style.foregroundColor,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (decoration.labelIcon != null) ...[
            decoration.labelIcon!,
            const SizedBox(width: 6),
          ],
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: labelWidget,
          ),
          if (decoration.required) ...[
            const SizedBox(width: 4),
            CText.label(
              '*',
              size: TextSize.small,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// A widget that displays a text form field with customizable decoration and style.
class FieldContent extends StatelessWidget {
  const FieldContent({
    super.key,
    required this.decoration,
    required this.style,
    this.initialValue,
    this.autocorrect,
    this.onChanged,
    this.validator,
    this.onTap,
    this.obscureText,
    this.readOnly,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.controller,
    this.enabled,
    this.maxLines,
  });

  /// The decoration properties for the field.
  final CFieldDecoration decoration;

  /// The style properties for the field.
  final CFieldStyle style;

  /// The initial value of the field.
  final String? initialValue;

  /// Determines whether autocorrection is enabled.
  final bool? autocorrect;

  /// Callback function that is called when the value of the field changes.
  final void Function(String)? onChanged;

  /// Validation function that determines whether the field's value is valid.
  final String? Function(String?)? validator;

  /// Callback function that is called when the field is tapped.
  final void Function()? onTap;

  /// Determines whether the field's text is obscured.
  final bool? obscureText;

  /// Determines whether the field is read-only.
  final bool? readOnly;

  /// The type of keyboard to display for editing the field.
  final TextInputType? keyboardType;

  /// The action that will be triggered when the user submits information in the field.
  final TextInputAction? textInputAction;

  /// The focus node that should be used for this field.
  final FocusNode? focusNode;

  /// The controller for the field's text.
  final TextEditingController? controller;

  /// Determines whether the field is enabled.
  final bool? enabled;

  /// The maximum number of lines for the field.
  final int? maxLines;

  OutlineInputBorder _outline(BorderSide side) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(decoration.radius),
      borderSide: side,
    );
  }

  BorderSide get _restingSide => style.bordered ? BorderSide(color: style.foregroundColor, width: 1) : BorderSide.none;

  InputDecoration get inputDecoration {
    final errorSide = BorderSide(color: Colors.red[900] ?? Colors.red, width: 2);
    return InputDecoration(
      prefixIcon: decoration.prefixIcon,
      suffixIcon: decoration.suffixIcon,
      hintText: decoration.hintText,
      labelText: decoration.inlineLabelText,
      contentPadding: kCFieldContentPadding,
      isDense: false,
      filled: true,
      fillColor: Colors.transparent,
      hintStyle: TextStyle(color: style.foregroundColor.withValues(alpha: .7)),
      border: _outline(_restingSide),
      enabledBorder: _outline(_restingSide),
      focusedBorder: _outline(BorderSide(color: style.foregroundColor, width: 2)),
      errorBorder: _outline(errorSide),
      focusedErrorBorder: _outline(errorSide),
      disabledBorder: _outline(style.bordered ? const BorderSide(color: Colors.grey, width: 2) : BorderSide.none),
      errorStyle: TextStyle(
        color: Colors.red[900] ?? Colors.red,
        fontSize: 12,
        height: 1.3,
      ),
      errorMaxLines: 3,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: inputDecoration,
      cursorColor: style.foregroundColor,
      style: TextStyle(color: style.foregroundColor),
      autocorrect: autocorrect ?? false,
      onChanged: onChanged,
      validator: validator,
      onTap: onTap,
      obscureText: obscureText ?? false,
      readOnly: readOnly ?? false,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      focusNode: focusNode,
      controller: controller,
      enabled: enabled,
      maxLines: maxLines ?? 1,
    );
  }
}

/// A container widget that wraps its child with customizable decoration and style.
class FieldContainer extends StatelessWidget {
  const FieldContainer({
    super.key,
    required this.decoration,
    required this.style,
    required this.child,
  });

  /// The decoration properties for the container.
  final CFieldDecoration decoration;

  /// The style properties for the container.
  final CFieldStyle style;

  /// The widget to be displayed inside the container.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        FieldLabel(
          decoration: decoration,
          style: style,
        ),
        ClipRRect(
          borderRadius: BorderRadius.all(decoration.radius),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(decoration.radius),
              gradient: style.filled && style.backgroundColor == null ? style.gradient ?? CGradient.primaryToSecondary.opacity(0.3) : null,
              color: style.filled ? style.backgroundColor : null,
            ),
            child: child,
          ),
        ),
      ],
    );
  }
}
