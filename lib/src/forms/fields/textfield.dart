import 'package:caravaggio_ui/src/forms/fields/commons/internal_components.dart';
import 'package:caravaggio_ui/src/forms/fields/commons/classes.dart';
import 'package:flutter/material.dart';

/// A stylized text input field.
class CTextField extends StatelessWidget {
  /// Creates a [CTextField] instance.
  CTextField._({
    super.key,
    CFieldStyle? style,
    required this.decoration,
    this.validator,
    this.onChanged,
    this.onTap,
    this.obscureText,
    this.readOnly,
    this.keyboardType,
    this.autocorrect,
    this.textInputAction,
    this.focusNode,
    this.controller,
    this.enabled,
    this.maxLines,
    this.initialValue,
  })  : assert(initialValue == null || controller == null),
        style = style ?? CFieldStyle.simple();

  /// Style of the field.
  final CFieldStyle style;

  /// Decoration of the field.
  final CFieldDecoration decoration;

  /// Validator function for the field.
  final String? Function(String?)? validator;

  /// Function called when the text in the field changes.
  final void Function(String)? onChanged;

  /// Function called when the field is tapped.
  final void Function()? onTap;

  /// Indicates whether the field is read-only.
  final bool? readOnly;

  /// Indicates whether the text should be obscured.
  final bool? obscureText;

  /// The type of keyboard to use for editing the text.
  final TextInputType? keyboardType;

  /// Indicates whether auto-correction is enabled for the text field.
  final bool? autocorrect;

  /// Specifies the type of action that will be taken when the user submits the text input.
  final TextInputAction? textInputAction;

  /// Node that controls keyboard focus.
  final FocusNode? focusNode;

  /// Controller for the text field.
  final TextEditingController? controller;

  /// Indicates whether the text field is enabled.
  final bool? enabled;

  /// The maximum number of lines the field can have.
  final int? maxLines;

  /// The initial value of the text field.
  final String? initialValue;

  /// Creates a simple styled text field.
  factory CTextField.simple({
    Color? foregroundColor,
    CFieldDecoration decoration = const CFieldDecoration(),
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    void Function()? onTap,
    bool? obscureText,
    bool? readOnly,
    TextInputType? keyboardType,
    bool? autocorrect,
    TextInputAction? textInputAction,
    FocusNode? focusNode,
    TextEditingController? controller,
    String? initialValue,
    bool? enabled,
    int? maxLines,
  }) {
    return CTextField._(
      style: CFieldStyle.simple(foregroundColor: foregroundColor),
      decoration: decoration,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      obscureText: obscureText,
      readOnly: readOnly,
      keyboardType: keyboardType,
      autocorrect: autocorrect,
      textInputAction: textInputAction,
      focusNode: focusNode,
      controller: controller,
      initialValue: initialValue,
      enabled: enabled,
      maxLines: maxLines,
    );
  }

  /// Creates a bordered styled text field.
  factory CTextField.bordered({
    Color? foregroundColor,
    CFieldDecoration decoration = const CFieldDecoration(),
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    void Function()? onTap,
    bool? obscureText,
    bool? readOnly,
    TextInputType? keyboardType,
    bool? autocorrect,
    TextInputAction? textInputAction,
    FocusNode? focusNode,
    TextEditingController? controller,
    String? initialValue,
    bool? enabled,
    int? maxLines,
  }) {
    return CTextField._(
      style: CFieldStyle.bordered(foregroundColor: foregroundColor),
      decoration: decoration,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      obscureText: obscureText,
      readOnly: readOnly,
      keyboardType: keyboardType,
      autocorrect: autocorrect,
      textInputAction: textInputAction,
      focusNode: focusNode,
      controller: controller,
      initialValue: initialValue,
      enabled: enabled,
      maxLines: maxLines,
    );
  }

  /// Creates a filled styled text field.
  factory CTextField.filled({
    Color? backgroundColor,
    Color? foregroundColor,
    LinearGradient? gradient,
    CFieldDecoration decoration = const CFieldDecoration(),
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    void Function()? onTap,
    bool? obscureText,
    bool? readOnly,
    TextInputType? keyboardType,
    bool? autocorrect,
    TextInputAction? textInputAction,
    FocusNode? focusNode,
    TextEditingController? controller,
    bool? enabled,
    int? maxLines,
    String? initialValue,
  }) {
    return CTextField._(
      style: CFieldStyle.filled(backgroundColor: backgroundColor, foregroundColor: foregroundColor, gradient: gradient),
      decoration: decoration,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      obscureText: obscureText,
      readOnly: readOnly,
      keyboardType: keyboardType,
      autocorrect: autocorrect,
      textInputAction: textInputAction,
      focusNode: focusNode,
      controller: controller,
      enabled: enabled,
      maxLines: maxLines,
      initialValue: initialValue,
    );
  }

  /// Creates a bordered and filled styled text field.
  factory CTextField.borderedFilled({
    Color? backgroundColor,
    Color? foregroundColor,
    LinearGradient? gradient,
    CFieldDecoration decoration = const CFieldDecoration(),
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    void Function()? onTap,
    bool? obscureText,
    bool? readOnly,
    TextInputType? keyboardType,
    bool? autocorrect,
    TextInputAction? textInputAction,
    FocusNode? focusNode,
    TextEditingController? controller,
    bool? enabled,
    int? maxLines,
    String? initialValue,
  }) {
    return CTextField._(
      style: CFieldStyle.borderedFilled(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        gradient: gradient,
      ),
      decoration: decoration,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      obscureText: obscureText,
      readOnly: readOnly,
      keyboardType: keyboardType,
      autocorrect: autocorrect,
      textInputAction: textInputAction,
      focusNode: focusNode,
      controller: controller,
      enabled: enabled,
      maxLines: maxLines,
      initialValue: initialValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FieldContainer(
      key: key,
      decoration: decoration,
      style: style,
      maxLines: maxLines,
      child: FieldContent(
        decoration: decoration,
        style: style,
        initialValue: initialValue,
        autocorrect: autocorrect,
        onChanged: onChanged,
        validator: validator,
        onTap: onTap,
        obscureText: obscureText,
        readOnly: readOnly,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        focusNode: focusNode,
        controller: controller,
        enabled: enabled,
        maxLines: maxLines,
      ),
    );
  }
}
