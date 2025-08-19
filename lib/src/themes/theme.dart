import 'package:caravaggio_ui/src/themes/theme_helper.dart';
import 'package:caravaggio_ui/src/utils/app_colors.dart';
import 'package:flutter/material.dart';

/// A class for initializing and accessing the Caravaggio UI theme and colors.
class CaravaggioUI {
  late ThemeData _themeData;

  late MaterialColor _materialPrimaryColor;
  late MaterialColor _materialSecondaryColor;

  late MaterialColor _onPrimaryMaterialColor;
  late MaterialColor _onSecondaryMaterialColor;
  late MaterialColor _onPrimaryLightMaterialColor;
  late MaterialColor _onSecondaryLightMaterialColor;
  late MaterialColor _onPrimaryDarkMaterialColor;
  late MaterialColor _onSecondaryDarkMaterialColor;

  /// Private constructor for singleton pattern.
  CaravaggioUI._();

  /// Singleton instance of [CaravaggioUI].
  static final CaravaggioUI _instance = CaravaggioUI._();

  /// Returns the singleton instance of [CaravaggioUI].
  static CaravaggioUI get instance => _instance;

  /// Initializes the Caravaggio UI theme.
  ///
  /// [primaryColor] is the primary color of the theme.
  /// [secondaryColor] is the secondary color of the theme (defaults [Colors.transparent]).
  /// [fontFamily] is the optional font family for the theme.
  factory CaravaggioUI.initialize({
    required Color primaryColor,
    Color secondaryColor = Colors.transparent,
    String? fontFamily,
    bool scaffoldBackgroundColor = false,
  }) {
    // Create a MaterialColor from the primary color
    final MaterialColor primaryMaterialColor = AppColors.from(primaryColor);

    // Create a MaterialColor from the secondary color
    final MaterialColor secondaryMaterialColor = AppColors.from(secondaryColor);

    final MaterialColor onPrimaryMaterialColor = AppColors.onFrom(primaryColor);

    final MaterialColor onSecondaryMaterialColor = AppColors.onFrom(secondaryColor);

    final MaterialColor onPrimaryLightMaterialColor = AppColors.onFrom(primaryMaterialColor[200] ?? primaryMaterialColor);

    final MaterialColor onSecondaryLightMaterialColor = AppColors.onFrom(secondaryMaterialColor[200] ?? secondaryMaterialColor);

    final MaterialColor onPrimaryDarkMaterialColor = AppColors.onFrom(primaryMaterialColor[800] ?? primaryMaterialColor);

    final MaterialColor onSecondaryDarkMaterialColor = AppColors.onFrom(secondaryMaterialColor[800] ?? secondaryMaterialColor);

    // Set the primary MaterialColor in the singleton instance
    _instance._materialPrimaryColor = primaryMaterialColor;

    // Set the secondary MaterialColor in the singleton instance
    _instance._materialSecondaryColor = secondaryMaterialColor;

    // Set the onPrimary and onSecondary MaterialColors in the singleton instance
    _instance._onPrimaryMaterialColor = onPrimaryMaterialColor;
    _instance._onSecondaryMaterialColor = onSecondaryMaterialColor;
    _instance._onPrimaryLightMaterialColor = onPrimaryLightMaterialColor;
    _instance._onSecondaryLightMaterialColor = onSecondaryLightMaterialColor;
    _instance._onPrimaryDarkMaterialColor = onPrimaryDarkMaterialColor;
    _instance._onSecondaryDarkMaterialColor = onSecondaryDarkMaterialColor;

    // Initialize ThemeHelper with the primary and secondary MaterialColors
    final ThemeHelper themeHelper = ThemeHelper(
      primaryMaterialColor: primaryMaterialColor,
      secondaryMaterialColor: secondaryMaterialColor,
    );

    // Create a ThemeData object with various theme settings
    _instance._themeData = ThemeData(
      useMaterial3: true, // Enable Material 3 design
      fontFamily: fontFamily, // Set the font family
      primarySwatch: primaryMaterialColor, // Set the primary swatch color
      primaryColor: primaryMaterialColor, // Set the primary color
      primaryColorLight: primaryMaterialColor[200], // Set the light primary color
      buttonTheme: themeHelper.buttonTheme, // Set the button theme
      outlinedButtonTheme: themeHelper.outlinedButtonTheme, // Set the outlined button theme
      floatingActionButtonTheme: themeHelper.floatingActionButtonTheme, // Set the floating action button theme
      disabledColor: Colors.grey, // Set the disabled color
      inputDecorationTheme: themeHelper.inputDecorationTheme, // Set the input decoration theme
      appBarTheme: themeHelper.appBarTheme, // Set the app bar theme
      bottomNavigationBarTheme: themeHelper.bottomNavigationBarTheme, // Set the bottom navigation bar theme
      progressIndicatorTheme: themeHelper.progressIndicatorTheme, // Set the progress indicator theme
      scaffoldBackgroundColor: scaffoldBackgroundColor ? primaryMaterialColor[50] : null, // Set the scaffold background color
      colorScheme: themeHelper.colorScheme, // Set the color scheme
      iconTheme: themeHelper.iconTheme, // Set the icon theme
    );

    // Return the singleton instance
    return _instance;
  }

  /// Returns the initialized theme data.
  ThemeData get themeData => _themeData;

  /// Returns the primary color.
  MaterialColor get primary => _materialPrimaryColor;

  /// Returns the secondary color.
  MaterialColor get secondary => _materialSecondaryColor;

  /// Returns the primary color.
  Color get primaryColor => _materialPrimaryColor;

  /// Returns the light variant of primary color.
  Color get primaryColorLight => _materialPrimaryColor[200] ?? _materialPrimaryColor;

  /// Returns the dark variant of primary color.
  Color get primaryColorDark => _materialPrimaryColor[800] ?? _materialPrimaryColor;

  /// Returns the secondary color.
  Color get secondaryColor => _materialSecondaryColor;

  /// Returns the light variant of secondary color.
  Color get secondaryColorLight => _materialSecondaryColor[200] ?? _materialSecondaryColor;

  /// Returns the dark variant of secondary color.
  Color get secondaryColorDark => _materialSecondaryColor[800] ?? _materialSecondaryColor;

  /// Returns the onPrimary color.
  Color get onPrimaryColor => _onPrimaryMaterialColor;

  /// Returns the onSecondary color.
  Color get onSecondaryColor => _onSecondaryMaterialColor;

  /// Returns the onPrimary light variant color.
  Color get onPrimaryLightColor => _onPrimaryLightMaterialColor;

  /// Returns the onSecondary light variant color.
  Color get onSecondaryLightColor => _onSecondaryLightMaterialColor;

  /// Returns the onPrimary dark variant color.
  Color get onPrimaryDarkColor => _onPrimaryDarkMaterialColor;

  /// Returns the onSecondary dark variant color.
  Color get onSecondaryDarkColor => _onSecondaryDarkMaterialColor;
}
