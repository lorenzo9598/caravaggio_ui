import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:flutter/material.dart';

/// A widget that displays a text form field with customizable decoration and style.
class FieldContent extends StatelessWidget {
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

  const FieldContent({
    Key? key,
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
  }) : super(key: key);

  InputDecoration get inputDecoration => InputDecoration(
        prefixIcon: decoration.prefixIcon,
        suffixIcon: decoration.suffixIcon,
        hintText: decoration.hintText,
        hintStyle: TextStyle(
          color: style.foregroundColor.withOpacity(0.5),
          fontStyle: FontStyle.italic,
        ),
        labelText: decoration.labelText,
        labelStyle: TextStyle(
          color: style.foregroundColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(decoration.borderRadius)),
          borderSide: style.bordered ? BorderSide(color: style.foregroundColor, width: 1) : BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(decoration.borderRadius)),
          borderSide: BorderSide(color: style.foregroundColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(decoration.borderRadius)),
          borderSide: BorderSide(color: Colors.red[900] ?? Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(decoration.borderRadius)),
          borderSide: BorderSide(color: Colors.red[900] ?? Colors.red, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(decoration.borderRadius)),
          borderSide: style.bordered ? const BorderSide(color: Colors.grey, width: 2) : BorderSide.none,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: inputDecoration,
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
  /// The decoration properties for the container.
  final CFieldDecoration decoration;

  /// The style properties for the container.
  final CFieldStyle style;

  /// The widget to be displayed inside the container.
  final Widget child;

  const FieldContainer({
    Key? key,
    required this.decoration,
    required this.style,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(decoration.borderRadius),
        ),
        gradient: style.filled ? style.gradient ?? CGradient.primaryToSecondary.opacity(0.3) : null,
        color: style.filled ? style.backgroundColor : null,
      ),
      child: child,
    );
  }
}
