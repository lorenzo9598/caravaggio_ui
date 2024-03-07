import 'package:caravaggio_ui/src/utils/color_generator.dart';
import 'package:flutter/material.dart';

/// A class for initializing and accessing the Caravaggio UI theme and colors.
class CaravaggioUI {
  late ThemeData _themeData;

  late MaterialColor _materialPrimaryColor;
  late MaterialColor _materialSecondaryColor;

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
  }) {
    MaterialColor primaryMaterialColor = MaterialColorGenerator.from(primaryColor);
    MaterialColor secondaryMaterialColor = MaterialColorGenerator.from(secondaryColor);

    _instance._materialPrimaryColor = primaryMaterialColor;
    _instance._materialSecondaryColor = secondaryMaterialColor;

    _instance._themeData = ThemeData(
      useMaterial3: true,
      fontFamily: fontFamily,
      primarySwatch: primaryMaterialColor,
      primaryColor: primaryMaterialColor,
      primaryColorLight: primaryMaterialColor[200],
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(side: BorderSide(color: primaryMaterialColor, width: 1)),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: primaryMaterialColor,
        textTheme: ButtonTextTheme.primary,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryMaterialColor[200],
        hoverColor: primaryMaterialColor,
      ),
      disabledColor: Colors.grey,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      appBarTheme: AppBarTheme(
        foregroundColor: primaryMaterialColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
        backgroundColor: primaryMaterialColor,
        elevation: 0,
        iconTheme: IconThemeData(color: secondaryMaterialColor),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: primaryMaterialColor,
        selectedItemColor: secondaryMaterialColor,
        unselectedItemColor: secondaryMaterialColor[200],
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        circularTrackColor: primaryMaterialColor[200],
        color: primaryMaterialColor,
      ),
    );
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
}
