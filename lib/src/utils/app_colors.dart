import 'dart:math';

import 'package:flutter/material.dart';

/// A utility class to generate MaterialColor from a given color.
class AppColors {
  /// Light gray color palette.
  static const grayLight = MaterialColor(
    0xFF667085,
    {
      50: Color(0xFFFCFCFD),
      100: Color(0xFFF9FAFB),
      150: Color(0xFFF2F4F7),
      200: Color(0xFFEAECF0),
      250: Color(0xFFD0D5DD),
      300: Color(0xFF98A2B3),
      400: Color(0xFF667085),
      500: Color(0xFF475467),
      600: Color(0xFF344054),
      700: Color(0xFF182230),
      800: Color(0xFF101828),
      900: Color(0xFF0C111D),
    },
  );

  /// Dark gray color palette.
  static const grayDark = MaterialColor(
    0xFF85888E,
    {
      50: Color(0xFFFAFAFA),
      100: Color(0xFFF5F5F6),
      150: Color(0xFFF0F1F1),
      200: Color(0xFFECECED),
      250: Color(0xFFCECFD2),
      300: Color(0xFF94969C),
      400: Color(0xFF85888E),
      500: Color(0xFF61646C),
      600: Color(0xFF333741),
      700: Color(0xFF1F242F),
      800: Color(0xFF161B26),
      900: Color(0xFF0C111D),
    },
  );

  /// Generates a MaterialColor from the provided color.
  static MaterialColor from(Color color) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }

  /// Calculates the tint value based on the given factor.
  static int tintValue(int value, double factor) => max(0, min((value + ((255 - value) * factor)).round(), 255));

  /// Calculates the tint color based on the given factor.
  static Color tintColor(Color color, double factor) => Color.fromRGBO(tintValue(color.red, factor), tintValue(color.green, factor), tintValue(color.blue, factor), 1);

  /// Calculates the shade value based on the given factor.
  static int shadeValue(int value, double factor) => max(0, min(value - (value * factor).round(), 255));

  /// Calculates the shade color based on the given factor.
  static Color shadeColor(Color color, double factor) => Color.fromRGBO(shadeValue(color.red, factor), shadeValue(color.green, factor), shadeValue(color.blue, factor), 1);

  /// Error color used for error messages and indicators
  static const Color errorColor = Color(0xFFC91432);

  /// Success color used for success messages and indicators
  static const Color successColor = Color(0xFF138636);

  /// Warning color used for warning messages and indicators
  static const Color warningColor = Color(0xFFFFBC11);

  /// Info color used for informational messages and indicators
  static const Color infoColor = Color(0xFF4976BA);

  /// White color used for backgrounds and text
  static const Color white = Colors.white;

  /// Black color used for text and backgrounds
  static const Color black = Colors.black;

  /// Transparent color used for invisible elements
  static const Color transparent = Colors.transparent;
}
