import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:flutter/material.dart';

/// Enumeration defining the type of gradient colors.
enum CGradientColorType {
  /// Gradient from primary light to primary color.
  primaryLightToPrimary,

  /// Gradient from primary light to primary dark color.
  primaryLightToPrimaryDark,

  /// Gradient from primary light to secondary light color.
  primaryLightToSecondaryLight,

  /// Gradient from primary light to secondary color.
  primaryLightToSecondary,

  /// Gradient from primary light to secondary dark color.
  primaryLightToSecondaryDark,

  /// Gradient from primary color to primary dark color.
  primaryToPrimaryDark,

  /// Gradient from primary color to secondary light color.
  primaryToSecondaryLight,

  /// Gradient from primary color to secondary color.
  primaryToSecondary,

  /// Gradient from primary color to secondary dark color.
  primaryToSecondaryDark,

  /// Gradient from primary dark color to secondary light color.
  primaryDarkToSecondaryLight,

  /// Gradient from primary dark color to secondary color.
  primaryDarkToSecondary,

  /// Gradient from primary dark color to secondary dark color.
  primaryDarkToSecondaryDark,

  /// Gradient from secondary light color to secondary color.
  secondaryLightToSecondary,

  /// Gradient from secondary light color to secondary dark color.
  secondaryLightToSecondaryDark,

  /// Gradient from secondary color to secondary dark color.
  secondaryToSecondaryDark,
}

/// Enumeration defining the direction of a gradient.
enum CGradientDirection {
  /// Gradient direction from top-left to bottom-right.
  topLeftToBottomRight,

  /// Gradient direction from top-left to center-right.
  topLeftToCenterRight,

  /// Gradient direction from top-left to top-right.
  topLeftToTopRight,

  /// Gradient direction from center-left to bottom-right.
  centerLeftToBottomRight,

  /// Gradient direction from center-left to center-right.
  centerLeftToCenterRight,

  /// Gradient direction from center-left to top-right.
  centerLeftToTopRight,

  /// Gradient direction from bottom-left to bottom-right.
  bottomLeftToBottomRight,

  /// Gradient direction from bottom-left to center-right.
  bottomLeftToCenterRight,

  /// Gradient direction from bottom-left to top-right.
  bottomLeftToTopRight,
}

/// Extension on [LinearGradient] providing utility methods for Caravaggio UI gradients.
extension CGradient on LinearGradient {
  /// Returns a primary light gradient.
  static LinearGradient get primaryLight => _generate(CGradientColorType.primaryLightToPrimary, CGradientDirection.topLeftToBottomRight);

  /// Returns a primary dark gradient.
  static LinearGradient get primaryDark => _generate(CGradientColorType.primaryToPrimaryDark, CGradientDirection.topLeftToBottomRight);

  /// Returns a primary high contrast gradient.
  static LinearGradient get primaryHighContrast => _generate(CGradientColorType.primaryLightToPrimaryDark, CGradientDirection.topLeftToBottomRight);

  /// Returns a secondary light gradient.
  static LinearGradient get secondaryLight => _generate(CGradientColorType.secondaryLightToSecondary, CGradientDirection.topLeftToBottomRight);

  /// Returns a secondary dark gradient.
  static LinearGradient get secondaryDark => _generate(CGradientColorType.secondaryToSecondaryDark, CGradientDirection.topLeftToBottomRight);

  /// Returns a secondary high contrast gradient.
  static LinearGradient get secondaryHighContrast => _generate(CGradientColorType.secondaryLightToSecondaryDark, CGradientDirection.topLeftToBottomRight);

  /// Returns a gradient from primary to secondary colors.
  static LinearGradient get primaryToSecondary => _generate(CGradientColorType.primaryToSecondary, CGradientDirection.topLeftToBottomRight);

  /// Returns a gradient from primary light to secondary light colors.
  static LinearGradient get primaryLightToSecondaryLight => _generate(CGradientColorType.primaryLightToSecondaryLight, CGradientDirection.topLeftToBottomRight);

  /// Returns a gradient from primary dark to secondary dark colors.
  static LinearGradient get primaryDarkToSecondaryDark => _generate(CGradientColorType.primaryDarkToSecondaryDark, CGradientDirection.topLeftToBottomRight);

  /// Returns a custom gradient with specified colors and direction.
  static LinearGradient custom({
    required CGradientColorType colors,
    required CGradientDirection direction,
    double opacity = 1,
  }) {
    return _generate(colors, direction, opacity: opacity);
  }

  /// Generates a linear gradient based on the provided color type and direction.
  static LinearGradient _generate(CGradientColorType type, CGradientDirection direction, {double opacity = 1}) {
    return LinearGradient(
      begin: _begin(direction),
      end: _end(direction),
      colors: _colors(type, opacity: opacity),
    );
  }

  /// Returns the begin alignment based on the gradient direction.
  static Alignment _begin(CGradientDirection direction) {
    switch (direction) {
      case CGradientDirection.topLeftToBottomRight:
      case CGradientDirection.topLeftToCenterRight:
      case CGradientDirection.topLeftToTopRight:
        return Alignment.topLeft;
      case CGradientDirection.centerLeftToBottomRight:
      case CGradientDirection.centerLeftToCenterRight:
      case CGradientDirection.centerLeftToTopRight:
        return Alignment.centerLeft;
      case CGradientDirection.bottomLeftToBottomRight:
      case CGradientDirection.bottomLeftToCenterRight:
      case CGradientDirection.bottomLeftToTopRight:
        return Alignment.bottomLeft;
    }
  }

  /// Returns the end alignment based on the gradient direction.
  static Alignment _end(CGradientDirection direction) {
    switch (direction) {
      case CGradientDirection.topLeftToBottomRight:
        return Alignment.bottomRight;
      case CGradientDirection.topLeftToCenterRight:
        return Alignment.centerRight;
      case CGradientDirection.topLeftToTopRight:
        return Alignment.topRight;
      case CGradientDirection.centerLeftToBottomRight:
        return Alignment.bottomRight;
      case CGradientDirection.centerLeftToCenterRight:
        return Alignment.centerRight;
      case CGradientDirection.centerLeftToTopRight:
        return Alignment.topRight;
      case CGradientDirection.bottomLeftToBottomRight:
        return Alignment.bottomRight;
      case CGradientDirection.bottomLeftToCenterRight:
        return Alignment.centerRight;
      case CGradientDirection.bottomLeftToTopRight:
        return Alignment.topRight;
    }
  }

  /// Returns the list of colors based on the gradient color type.
  static List<Color> _colors(CGradientColorType type, {double opacity = 1}) {
    late List<Color> colors;
    switch (type) {
      case CGradientColorType.primaryLightToPrimary:
        colors = [CaravaggioUI.instance.primaryColorLight, CaravaggioUI.instance.primaryColor];
        break;
      case CGradientColorType.primaryLightToPrimaryDark:
        colors = [CaravaggioUI.instance.primaryColorLight, CaravaggioUI.instance.primaryColorDark];
        break;
      case CGradientColorType.primaryLightToSecondaryLight:
        colors = [CaravaggioUI.instance.primaryColorLight, CaravaggioUI.instance.secondaryColorLight];
        break;
      case CGradientColorType.primaryLightToSecondary:
        colors = [CaravaggioUI.instance.primaryColorLight, CaravaggioUI.instance.secondaryColor];
        break;
      case CGradientColorType.primaryLightToSecondaryDark:
        colors = [CaravaggioUI.instance.primaryColorLight, CaravaggioUI.instance.secondaryColorDark];
        break;
      case CGradientColorType.primaryToPrimaryDark:
        colors = [CaravaggioUI.instance.primaryColor, CaravaggioUI.instance.primaryColorDark];
        break;
      case CGradientColorType.primaryToSecondaryLight:
        colors = [CaravaggioUI.instance.primaryColor, CaravaggioUI.instance.secondaryColorLight];
        break;
      case CGradientColorType.primaryToSecondary:
        colors = [CaravaggioUI.instance.primaryColor, CaravaggioUI.instance.secondaryColor];
        break;
      case CGradientColorType.primaryToSecondaryDark:
        colors = [CaravaggioUI.instance.primaryColor, CaravaggioUI.instance.secondaryColorDark];
        break;
      case CGradientColorType.primaryDarkToSecondaryLight:
        colors = [CaravaggioUI.instance.primaryColorDark, CaravaggioUI.instance.secondaryColorLight];
        break;
      case CGradientColorType.primaryDarkToSecondary:
        colors = [CaravaggioUI.instance.primaryColorDark, CaravaggioUI.instance.secondaryColor];
        break;
      case CGradientColorType.primaryDarkToSecondaryDark:
        colors = [CaravaggioUI.instance.primaryColorDark, CaravaggioUI.instance.secondaryColorDark];
        break;
      case CGradientColorType.secondaryLightToSecondary:
        colors = [CaravaggioUI.instance.secondaryColorLight, CaravaggioUI.instance.secondaryColor];
        break;
      case CGradientColorType.secondaryLightToSecondaryDark:
        colors = [CaravaggioUI.instance.secondaryColorLight, CaravaggioUI.instance.secondaryColorDark];
        break;
      case CGradientColorType.secondaryToSecondaryDark:
        colors = [CaravaggioUI.instance.secondaryColor, CaravaggioUI.instance.secondaryColorDark];
        break;
    }
    return colors.map((color) => color.withOpacity(opacity)).toList();
  }

  /// Returns a new gradient with reversed colors.
  LinearGradient get reverse => LinearGradient(
        begin: end,
        end: begin,
        colors: colors,
      );

  /// Returns a new gradient with adjusted opacity for all colors.
  LinearGradient opacity(double opacity) => LinearGradient(
        begin: begin,
        end: end,
        colors: colors.map((color) => color.withOpacity(opacity)).toList(),
      );
}
