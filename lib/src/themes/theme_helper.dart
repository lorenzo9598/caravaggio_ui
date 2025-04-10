import 'package:caravaggio_ui/src/utils/app_colors.dart';
import 'package:flutter/material.dart';

/// Helper class to manage theme data
class ThemeHelper {
  /// Constructor to initialize the theme helper with primary and secondary colors
  ThemeHelper({
    required this.primaryMaterialColor,
    required this.secondaryMaterialColor,
  });

  /// Primary material color used in the theme
  final MaterialColor primaryMaterialColor;

  /// Secondary material color used in the theme
  final MaterialColor secondaryMaterialColor;

  /// Returns the button theme data with primary color and text theme
  ButtonThemeData get buttonTheme {
    return ButtonThemeData(
      buttonColor: primaryMaterialColor,
      textTheme: ButtonTextTheme.primary,
      disabledColor: Colors.grey,
    );
  }

  /// Returns the outlined button theme data with primary color border
  OutlinedButtonThemeData get outlinedButtonTheme {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(side: BorderSide(color: primaryMaterialColor, width: 1)),
    );
  }

  /// Returns the color scheme with primary and secondary colors
  ColorScheme get colorScheme {
    return ColorScheme(
      brightness: Brightness.light,
      primary: primaryMaterialColor,
      onPrimary: primaryMaterialColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
      secondary: secondaryMaterialColor,
      onSecondary: secondaryMaterialColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
      error: AppColors.errorColor,
      onError: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
    );
  }

  /// Returns the icon theme data with primary color
  IconThemeData get iconTheme {
    return IconThemeData(
      color: primaryMaterialColor,
    );
  }

  /// Returns the floating action button theme data with primary color
  FloatingActionButtonThemeData get floatingActionButtonTheme {
    return FloatingActionButtonThemeData(
      backgroundColor: primaryMaterialColor[200],
      hoverColor: primaryMaterialColor,
    );
  }

  /// Returns the app bar theme data with primary color and secondary icon color
  AppBarTheme get appBarTheme {
    return AppBarTheme(
      foregroundColor: primaryMaterialColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
      backgroundColor: primaryMaterialColor,
      elevation: 0,
      iconTheme: IconThemeData(color: secondaryMaterialColor),
    );
  }

  /// Returns the input decoration theme data with outlined border and white fill color
  InputDecorationTheme get inputDecorationTheme {
    return InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }

  /// Returns the bottom navigation bar theme data with primary background color and secondary selected item color
  BottomNavigationBarThemeData get bottomNavigationBarTheme {
    return BottomNavigationBarThemeData(
      backgroundColor: primaryMaterialColor,
      selectedItemColor: secondaryMaterialColor,
      unselectedItemColor: primaryMaterialColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
    );
  }

  /// Returns the progress indicator theme data with primary color
  ProgressIndicatorThemeData get progressIndicatorTheme {
    return ProgressIndicatorThemeData(
      circularTrackColor: primaryMaterialColor[200],
      color: primaryMaterialColor,
    );
  }
}
