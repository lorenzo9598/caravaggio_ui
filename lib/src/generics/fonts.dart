import 'package:caravaggio_ui/src/theme.dart';
import 'package:flutter/material.dart';

/// Extension methods for [TextStyle] related to Caravaggio UI theme.
extension CText on TextStyle {
  /// Default text style.
  static const TextStyle style = TextStyle();

  /// Font size for display large text.
  static const double displayLargeSize = 57;

  /// Font size for display medium text.
  static const double displayMediumSize = 52;

  /// Font size for display small text.
  static const double displaySmallSize = 44;

  /// Font size for headline large text.
  static const double headlineLargeSize = 40;

  /// Font size for headline medium text.
  static const double headlineMediumSize = 36;

  /// Font size for headline small text.
  static const double headlineSmallSize = 32;

  /// Font size for title large text.
  static const double titleLargeSize = 28;

  /// Font size for title medium text.
  static const double titleMediumSize = 24;

  /// Font size for title small text.
  static const double titleSmallSize = 20;

  /// Font size for body large text.
  static const double bodyLargeSize = 24;

  /// Font size for body medium text.
  static const double bodyMediumSize = 20;

  /// Font size for body small text.
  static const double bodySmallSize = 16;

  /// Font size for label large text.
  static const double labelLargeSize = 14;

  /// Font size for label medium text.
  static const double labelMediumSize = 12;

  /// Font size for label small text.
  static const double labelSmallSize = 11;

  /// Applies display large text size to the current text style.
  TextStyle get displayLarge => copyWith(fontSize: displayLargeSize);

  /// Applies display medium text size to the current text style.
  TextStyle get displayMedium => copyWith(fontSize: displayMediumSize);

  /// Applies display small text size to the current text style.
  TextStyle get displaySmall => copyWith(fontSize: displaySmallSize);

  /// Applies headline large text size to the current text style.
  TextStyle get headlineLarge => copyWith(fontSize: headlineLargeSize);

  /// Applies headline medium text size to the current text style.
  TextStyle get headlineMedium => copyWith(fontSize: headlineMediumSize);

  /// Applies headline small text size to the current text style.
  TextStyle get headlineSmall => copyWith(fontSize: headlineSmallSize);

  /// Applies title large text size to the current text style.
  TextStyle get titleLarge => copyWith(fontSize: titleLargeSize);

  /// Applies title medium text size to the current text style.
  TextStyle get titleMedium => copyWith(fontSize: titleMediumSize);

  /// Applies title small text size to the current text style.
  TextStyle get titleSmall => copyWith(fontSize: titleSmallSize);

  /// Applies body large text size to the current text style.
  TextStyle get bodyLarge => copyWith(fontSize: bodyLargeSize);

  /// Applies body medium text size to the current text style.
  TextStyle get bodyMedium => copyWith(fontSize: bodyMediumSize);

  /// Applies body small text size to the current text style.
  TextStyle get bodySmall => copyWith(fontSize: bodySmallSize);

  /// Applies label large text size to the current text style.
  TextStyle get labelLarge => copyWith(fontSize: labelLargeSize);

  /// Applies label medium text size to the current text style.
  TextStyle get labelMedium => copyWith(fontSize: labelMediumSize);

  /// Applies label small text size to the current text style.
  TextStyle get labelSmall => copyWith(fontSize: labelSmallSize);

  /// Applies primary light color to the current text style.
  TextStyle get primaryLight =>
      copyWith(color: CaravaggioUI.instance.primaryColorLight);

  /// Applies primary color to the current text style.
  TextStyle get primary => copyWith(color: CaravaggioUI.instance.primaryColor);

  /// Applies primary dark color to the current text style.
  TextStyle get primaryDark =>
      copyWith(color: CaravaggioUI.instance.primaryColorDark);

  /// Applies secondary color to the current text style.
  TextStyle get secondary =>
      copyWith(color: CaravaggioUI.instance.secondaryColor);

  /// Applies secondary light color to the current text style.
  TextStyle get secondaryLight =>
      copyWith(color: CaravaggioUI.instance.secondaryColorLight);

  /// Applies secondary dark color to the current text style.
  TextStyle get secondaryDark =>
      copyWith(color: CaravaggioUI.instance.secondaryColorDark);

  /// Applies white color to the current text style.
  TextStyle get white => copyWith(color: Colors.white);

  /// Applies bold font weight to the current text style.
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);

  /// Applies italic font style to the current text style.
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
}
