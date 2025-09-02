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
  @Deprecated('CaravaggioUI.instance.themeData is deprecated. Use CUI.themeData instead.')
  ThemeData get themeData => _themeData;

  /// Returns the primary color.
  @Deprecated('CaravaggioUI.instance.primary is deprecated. Use CColors.primary instead.')
  MaterialColor get primary => _materialPrimaryColor;

  /// Returns the secondary color.
  @Deprecated('CaravaggioUI.instance.secondary is deprecated. Use CColors.secondary instead.')
  MaterialColor get secondary => _materialSecondaryColor;

  /// Returns the primary color.
  @Deprecated('CaravaggioUI.instance.primaryColor is deprecated. Use CColors.primaryColor instead.')
  Color get primaryColor => _materialPrimaryColor;

  /// Returns the light variant of primary color.
  @Deprecated('CaravaggioUI.instance.primaryColorLight is deprecated. Use CColors.primaryColorLight instead.')
  Color get primaryColorLight => _materialPrimaryColor[200] ?? _materialPrimaryColor;

  /// Returns the dark variant of primary color.
  @Deprecated('CaravaggioUI.instance.primaryColorDark is deprecated. Use CColors.primaryColorDark instead.')
  Color get primaryColorDark => _materialPrimaryColor[800] ?? _materialPrimaryColor;

  /// Returns the secondary color.
  @Deprecated('CaravaggioUI.instance.secondaryColor is deprecated. Use CColors.secondaryColor instead.')
  Color get secondaryColor => _materialSecondaryColor;

  /// Returns the light variant of secondary color.
  @Deprecated('CaravaggioUI.instance.secondaryColorLight is deprecated. Use CColors.secondaryColorLight instead.')
  Color get secondaryColorLight => _materialSecondaryColor[200] ?? _materialSecondaryColor;

  /// Returns the dark variant of secondary color.
  @Deprecated('CaravaggioUI.instance.secondaryColorDark is deprecated. Use CColors.secondaryColorDark instead.')
  Color get secondaryColorDark => _materialSecondaryColor[800] ?? _materialSecondaryColor;

  /// Returns the onPrimary color.
  @Deprecated('CaravaggioUI.instance.onPrimaryColor is deprecated. Use CColors.onPrimaryColor instead.')
  Color get onPrimaryColor => _onPrimaryMaterialColor;

  /// Returns the onSecondary color.
  @Deprecated('CaravaggioUI.instance.onSecondaryColor is deprecated. Use CColors.onSecondaryColor instead.')
  Color get onSecondaryColor => _onSecondaryMaterialColor;

  /// Returns the onPrimary light variant color.
  @Deprecated('CaravaggioUI.instance.onPrimaryLightColor is deprecated. Use CColors.onPrimaryLightColor instead.')
  Color get onPrimaryLightColor => _onPrimaryLightMaterialColor;

  /// Returns the onSecondary light variant color.
  @Deprecated('CaravaggioUI.instance.onSecondaryLightColor is deprecated. Use CColors.onSecondaryLightColor instead.')
  Color get onSecondaryLightColor => _onSecondaryLightMaterialColor;

  /// Returns the onPrimary dark variant color.
  @Deprecated('CaravaggioUI.instance.onPrimaryDarkColor is deprecated. Use CColors.onPrimaryDarkColor instead.')
  Color get onPrimaryDarkColor => _onPrimaryDarkMaterialColor;

  /// Returns the onSecondary dark variant color.
  @Deprecated('CaravaggioUI.instance.onSecondaryDarkColor is deprecated. Use CColors.onSecondaryDarkColor instead.')
  Color get onSecondaryDarkColor => _onSecondaryDarkMaterialColor;
}

class CUI {
  CUI._();

  /// Returns the initialized theme data.
  // ignore: deprecated_member_use_from_same_package
  static ThemeData get themeData => CaravaggioUI.instance.themeData;
}

class CColors {
  CColors._();

  /// Returns the primary color.
  // ignore: deprecated_member_use_from_same_package
  static MaterialColor get primary => CaravaggioUI.instance.primary;

  /// Returns the secondary color.
  // ignore: deprecated_member_use_from_same_package
  static MaterialColor get secondary => CaravaggioUI.instance.secondary;

  /// Returns the primary color.
  // ignore: deprecated_member_use_from_same_package
  static Color get primaryColor => CaravaggioUI.instance.primaryColor;

  /// Returns the light variant of primary color.
  // ignore: deprecated_member_use_from_same_package
  static Color get primaryColorLight => CaravaggioUI.instance.primaryColorLight;

  /// Returns the dark variant of primary color.
  // ignore: deprecated_member_use_from_same_package
  static Color get primaryColorDark => CaravaggioUI.instance.primaryColorDark;

  /// Returns the secondary color.
  // ignore: deprecated_member_use_from_same_package
  static Color get secondaryColor => CaravaggioUI.instance.secondaryColor;

  /// Returns the light variant of secondary color.
  // ignore: deprecated_member_use_from_same_package
  static Color get secondaryColorLight => CaravaggioUI.instance.secondaryColorLight;

  /// Returns the dark variant of secondary color.
  // ignore: deprecated_member_use_from_same_package
  static Color get secondaryColorDark => CaravaggioUI.instance.secondaryColorDark;

  /// Returns the onPrimary color.
  // ignore: deprecated_member_use_from_same_package
  static Color get onPrimaryColor => CaravaggioUI.instance.onPrimaryColor;

  /// Returns the onSecondary color.
  // ignore: deprecated_member_use_from_same_package
  static Color get onSecondaryColor => CaravaggioUI.instance.onSecondaryColor;

  /// Returns the onPrimary light variant color.
  // ignore: deprecated_member_use_from_same_package
  static Color get onPrimaryLightColor => CaravaggioUI.instance.onPrimaryLightColor;

  /// Returns the onSecondary light variant color.
  // ignore: deprecated_member_use_from_same_package
  static Color get onSecondaryLightColor => CaravaggioUI.instance.onSecondaryLightColor;

  /// Returns the onPrimary dark variant color.
  // ignore: deprecated_member_use_from_same_package
  static Color get onPrimaryDarkColor => CaravaggioUI.instance.onPrimaryDarkColor;

  /// Returns the onSecondary dark variant color.
  // ignore: deprecated_member_use_from_same_package
  static Color get onSecondaryDarkColor => CaravaggioUI.instance.onSecondaryDarkColor;
}
