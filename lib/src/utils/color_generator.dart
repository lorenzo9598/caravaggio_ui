import 'dart:math';

import 'package:flutter/material.dart';

/// A utility class to generate MaterialColor from a given color.
class MaterialColorHelper {
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
}
