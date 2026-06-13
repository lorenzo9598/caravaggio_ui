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

  late Color _configuredPrimaryColor;
  late Color _configuredSecondaryColor;
  Color? _configuredPrimaryColorLight;
  Color? _configuredPrimaryColorDark;
  Color? _configuredSecondaryColorLight;
  Color? _configuredSecondaryColorDark;
  String? _configuredFontFamily;
  bool _configuredScaffoldBackgroundColor = false;

  /// Notifies listeners when theme colors are updated at runtime.
  final ValueNotifier<int> colorsListenable = ValueNotifier<int>(0);

  /// Private constructor for singleton pattern.
  CaravaggioUI._();

  /// Singleton instance of [CaravaggioUI].
  static final CaravaggioUI _instance = CaravaggioUI._();

  /// Returns the singleton instance of [CaravaggioUI].
  static CaravaggioUI get instance => _instance;

  /// Initializes the Caravaggio UI theme.
  ///
  /// [primaryColor] is the primary color of the theme.
  /// [primaryColorLight] is the light variant of the primary color (overrides the auto-generated one).
  /// [primaryColorDark] is the dark variant of the primary color (overrides the auto-generated one).
  /// [secondaryColor] is the secondary color of the theme (defaults [Colors.transparent]).
  /// [secondaryColorLight] is the light variant of the secondary color (overrides the auto-generated one).
  /// [secondaryColorDark] is the dark variant of the secondary color (overrides the auto-generated one).
  /// [fontFamily] is the optional font family for the theme.
  factory CaravaggioUI.initialize({
    required Color primaryColor,
    Color? primaryColorLight,
    Color? primaryColorDark,
    Color secondaryColor = Colors.transparent,
    Color? secondaryColorLight,
    Color? secondaryColorDark,
    String? fontFamily,
    bool scaffoldBackgroundColor = false,
  }) {
    _instance._configuredPrimaryColor = primaryColor;
    _instance._configuredSecondaryColor = secondaryColor;
    _instance._configuredPrimaryColorLight = primaryColorLight;
    _instance._configuredPrimaryColorDark = primaryColorDark;
    _instance._configuredSecondaryColorLight = secondaryColorLight;
    _instance._configuredSecondaryColorDark = secondaryColorDark;
    _instance._configuredFontFamily = fontFamily;
    _instance._configuredScaffoldBackgroundColor = scaffoldBackgroundColor;
    _instance._applyTheme(notifyListeners: false);
    return _instance;
  }

  /// Updates primary and/or secondary colors at runtime.
  ///
  /// Light and dark variants are regenerated from the new base colors unless
  /// they were explicitly set during [initialize].
  void updateColors({
    Color? primaryColor,
    Color? secondaryColor,
  }) {
    if (primaryColor != null) {
      _configuredPrimaryColor = primaryColor;
      _configuredPrimaryColorLight = null;
      _configuredPrimaryColorDark = null;
    }
    if (secondaryColor != null) {
      _configuredSecondaryColor = secondaryColor;
      _configuredSecondaryColorLight = null;
      _configuredSecondaryColorDark = null;
    }
    _applyTheme();
  }

  void _applyTheme({bool notifyListeners = true}) {
    final MaterialColor primaryMaterialColor = _buildMaterialColor(
      _configuredPrimaryColor,
      lightVariant: _configuredPrimaryColorLight,
      darkVariant: _configuredPrimaryColorDark,
    );

    final MaterialColor secondaryMaterialColor = _buildMaterialColor(
      _configuredSecondaryColor,
      lightVariant: _configuredSecondaryColorLight,
      darkVariant: _configuredSecondaryColorDark,
    );

    final MaterialColor onPrimaryMaterialColor = AppColors.onFrom(_configuredPrimaryColor);
    final MaterialColor onSecondaryMaterialColor = AppColors.onFrom(_configuredSecondaryColor);
    final MaterialColor onPrimaryLightMaterialColor = AppColors.onFrom(primaryMaterialColor[200] ?? primaryMaterialColor);
    final MaterialColor onSecondaryLightMaterialColor = AppColors.onFrom(secondaryMaterialColor[200] ?? secondaryMaterialColor);
    final MaterialColor onPrimaryDarkMaterialColor = AppColors.onFrom(primaryMaterialColor[800] ?? primaryMaterialColor);
    final MaterialColor onSecondaryDarkMaterialColor = AppColors.onFrom(secondaryMaterialColor[800] ?? secondaryMaterialColor);

    _materialPrimaryColor = primaryMaterialColor;
    _materialSecondaryColor = secondaryMaterialColor;
    _onPrimaryMaterialColor = onPrimaryMaterialColor;
    _onSecondaryMaterialColor = onSecondaryMaterialColor;
    _onPrimaryLightMaterialColor = onPrimaryLightMaterialColor;
    _onSecondaryLightMaterialColor = onSecondaryLightMaterialColor;
    _onPrimaryDarkMaterialColor = onPrimaryDarkMaterialColor;
    _onSecondaryDarkMaterialColor = onSecondaryDarkMaterialColor;

    final ThemeHelper themeHelper = ThemeHelper(
      primaryMaterialColor: primaryMaterialColor,
      secondaryMaterialColor: secondaryMaterialColor,
    );

    _themeData = ThemeData(
      useMaterial3: true,
      fontFamily: _configuredFontFamily,
      primarySwatch: primaryMaterialColor,
      primaryColor: primaryMaterialColor,
      primaryColorLight: primaryMaterialColor[200],
      buttonTheme: themeHelper.buttonTheme,
      outlinedButtonTheme: themeHelper.outlinedButtonTheme,
      floatingActionButtonTheme: themeHelper.floatingActionButtonTheme,
      disabledColor: Colors.grey,
      inputDecorationTheme: themeHelper.inputDecorationTheme,
      appBarTheme: themeHelper.appBarTheme,
      bottomNavigationBarTheme: themeHelper.bottomNavigationBarTheme,
      progressIndicatorTheme: themeHelper.progressIndicatorTheme,
      scaffoldBackgroundColor: _configuredScaffoldBackgroundColor ? primaryMaterialColor[50] : null,
      colorScheme: themeHelper.colorScheme,
      iconTheme: themeHelper.iconTheme,
    );

    if (notifyListeners) {
      colorsListenable.value++;
    }
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

/// Builds a [MaterialColor] from a base [color], optionally overriding
/// the automatically generated light ([200]) and dark ([800]) variants.
MaterialColor _buildMaterialColor(
  Color color, {
  Color? lightVariant,
  Color? darkVariant,
}) {
  return MaterialColor(color.toARGB32(), {
    50: AppColors.tintColor(color, 0.9),
    100: AppColors.tintColor(color, 0.8),
    200: lightVariant ?? AppColors.tintColor(color, 0.6),
    300: AppColors.tintColor(color, 0.4),
    400: AppColors.tintColor(color, 0.2),
    500: color,
    600: AppColors.shadeColor(color, 0.1),
    700: AppColors.shadeColor(color, 0.2),
    800: darkVariant ?? AppColors.shadeColor(color, 0.3),
    900: AppColors.shadeColor(color, 0.4),
  });
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

/// Rebuilds when [CaravaggioUI.updateColors] changes the palette.
///
/// Use around widgets that resolve [CColors] or [CGradient] at build time so
/// their colors refresh. [Theme.of] alone does not rebuild const subtrees.
class CColorsBuilder extends StatelessWidget {
  const CColorsBuilder({super.key, required this.builder});

  final Widget Function(BuildContext context) builder;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: CaravaggioUI.instance.colorsListenable,
      builder: (context, _) => builder(context),
    );
  }
}
