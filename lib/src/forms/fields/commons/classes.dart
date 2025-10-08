import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:flutter/material.dart';

/// Decoration options for a form field.
class CFieldDecoration {
  /// Creates a [CFieldDecoration] instance.
  const CFieldDecoration({
    this.radius = AppRadius.s,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.labelText,
  });

  /// The border radius of the field decoration.
  final Radius radius;

  /// The prefix icon of the field decoration.
  final Widget? prefixIcon;

  /// The suffix icon of the field decoration.
  final Widget? suffixIcon;

  /// The hint text of the field decoration.
  final String? hintText;

  /// The label text of the field decoration.
  final String? labelText;

  /// Creates a copy of this decoration with the given fields replaced with the new values.
  CFieldDecoration copyWith({
    Radius? radius,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? hintText,
    String? labelText,
  }) {
    return CFieldDecoration(
      radius: radius ?? this.radius,
      prefixIcon: prefixIcon ?? this.prefixIcon,
      suffixIcon: suffixIcon ?? this.suffixIcon,
      hintText: hintText ?? this.hintText,
      labelText: labelText ?? this.labelText,
    );
  }
}

/// Style options for a form field.
class CFieldStyle {
  /// Background color of the field.
  final Color? backgroundColor;

  /// Foreground color of the field.
  final Color foregroundColor;

  /// Gradient of the field.
  final LinearGradient? gradient;

  /// Indicates if the field is filled.
  final bool filled;

  /// Indicates if the field is bordered.
  final bool bordered;

  /// Creates a [CFieldStyle] instance.
  CFieldStyle({
    this.backgroundColor,
    Color? foregroundColor,
    this.gradient,
    this.filled = false,
    this.bordered = false,
  }) : foregroundColor = foregroundColor ?? CColors.primaryColor;

  /// Creates a simple field style.
  factory CFieldStyle.simple({
    Color? foregroundColor,
  }) {
    return CFieldStyle(
      foregroundColor: foregroundColor,
    );
  }

  /// Creates a filled field style.
  factory CFieldStyle.filled({
    Color? backgroundColor,
    Color? foregroundColor,
    LinearGradient? gradient,
  }) {
    return CFieldStyle(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      gradient: gradient,
      filled: true,
    );
  }

  /// Creates a bordered field style.
  factory CFieldStyle.bordered({
    Color? foregroundColor,
  }) {
    return CFieldStyle(
      foregroundColor: foregroundColor,
      bordered: true,
    );
  }

  /// Creates a bordered and filled field style.
  factory CFieldStyle.borderedFilled({
    Color? backgroundColor,
    Color? foregroundColor,
    LinearGradient? gradient,
  }) {
    return CFieldStyle(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      gradient: gradient,
      filled: true,
      bordered: true,
    );
  }
}
