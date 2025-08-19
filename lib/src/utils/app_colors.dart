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

  static MaterialColor onFrom(Color color) {
    final Color contrastColor = _contrastColorSmall(color);
    return MaterialColor(contrastColor.value, {
      50: tintColor(contrastColor, 0.9),
      100: tintColor(contrastColor, 0.8),
      200: tintColor(contrastColor, 0.6),
      300: tintColor(contrastColor, 0.4),
      400: tintColor(contrastColor, 0.2),
      500: contrastColor,
      600: shadeColor(contrastColor, 0.1),
      700: shadeColor(contrastColor, 0.2),
      800: shadeColor(contrastColor, 0.3),
      900: shadeColor(contrastColor, 0.4),
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

  static Color _contrastColorSmall(Color color) => _getAccessibleContrastColor(color, color, 7.0);

  // static Color _contrastColorLarge(Color color) => _getAccessibleContrastColor(color, color, 4.5);

  static Color _getAccessibleContrastColor(Color baseColor, Color targetColor, double ratio) {
    if (_isCloseToBlack(targetColor, ratio) && _isDarkerOrSame(baseColor, targetColor)) {
      return _brightenToContrast(baseColor, targetColor, ratio);
    } else if (_isCloseToWhite(targetColor, ratio) && _isDarkerOrSame(targetColor, baseColor)) {
      return _darkenToContrast(baseColor, targetColor, ratio);
    } else if (_isDarkerOrSame(targetColor, baseColor)) {
      return _brightenToContrast(baseColor, targetColor, ratio);
    } else {
      return _darkenToContrast(baseColor, targetColor, ratio);
    }
  }

  static double _relativeLuminance(Color color) {
    final r = _linearize(color.red / 255.0);
    final g = _linearize(color.green / 255.0);
    final b = _linearize(color.blue / 255.0);
    return 0.2126 * r + 0.7152 * g + 0.0722 * b;
  }

  static double _linearize(double channel) => channel <= 0.03928 ? channel / 12.92 : pow((channel + 0.055) / 1.055, 2.4).toDouble();

  static double _contrastRatio(Color c1, Color c2) {
    final l1 = _relativeLuminance(c1);
    final l2 = _relativeLuminance(c2);
    return (max(l1, l2) + 0.05) / (min(l1, l2) + 0.05);
  }

  static bool _isDarkerOrSame(Color a, Color b) => _relativeLuminance(a) <= _relativeLuminance(b);
  static bool _isCloseToBlack(Color color, double ratio) => _contrastRatio(color, const Color(0xFF000000)) < ratio + 1;
  static bool _isCloseToWhite(Color color, double ratio) => _contrastRatio(color, const Color(0xFFFFFFFF)) < ratio + 1;

  static Color _darkenToContrast(Color fromColor, Color targetColor, double ratio) {
    final hsl = HSLColor.fromColor(fromColor);
    double l = hsl.lightness;
    while (l > 0) {
      final adjusted = hsl.withLightness(l).toColor();
      if (_contrastRatio(adjusted, targetColor) >= ratio) {
        return adjusted;
      }
      l -= 0.01;
    }
    return const Color(0xFF000000);
  }

  static Color _brightenToContrast(Color fromColor, Color targetColor, double ratio) {
    final hsl = HSLColor.fromColor(fromColor);
    double l = hsl.lightness;
    while (l < 1) {
      final adjusted = hsl.withLightness(l).toColor();
      if (_contrastRatio(adjusted, targetColor) >= ratio) {
        return adjusted;
      }
      l += 0.01;
    }
    return const Color(0xFFFFFFFF);
  }
}
