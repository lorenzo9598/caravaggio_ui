import 'package:caravaggio_ui/src/themes/theme.dart';
import 'package:caravaggio_ui/src/utils/app_radius.dart';
import 'package:flutter/material.dart';

/// Default radius for buttons
const Radius defaultRadius = AppRadius.xl;

/// [CButtonSize.small] set the button's height to 32.0.
/// Enumeration defining the size of a [CButton].
/// [CButtonSize.normal] set the button's height to 52.0.
enum CButtonSize {
  /// Extra small button size
  xSmall,

  /// Small button size
  small,

  /// Medium button size
  medium,

  /// Large button size
  large,

  /// Extra large button size
  xlarge,

  /// Extra extra large button size
  xxLarge;

  /// Returns the height of the button based on its size.
  double get height {
    switch (this) {
      case CButtonSize.xSmall:
        return 24.0; // Example value for xSmall
      case CButtonSize.small:
        return 34.0;
      case CButtonSize.medium:
        return 44.0;
      case CButtonSize.large:
        return 54.0; // Example value for large
      case CButtonSize.xlarge:
        return 66.0; // Example value for xlarge
      case CButtonSize.xxLarge:
        return 76.0; // Example value for xxLarge
    }
  }
}

/// Default elevation for elevated buttons (Material default is 1).
const double defaultButtonElevation = 1.0;

/// Default padding between icon and text in buttons.
const double defaultIconPadding = 8.0;

/// Class defining the decoration properties for a [CButton].
class CButtonDecoration {
  const CButtonDecoration({
    this.icon,
    this.suffixIcon,
    this.size = CButtonSize.medium,
    this.iconPadding = defaultIconPadding,
    this.suffixIconPadding = defaultIconPadding,
    this.filledColor,
    this.borderColor,
    this.gradient,
    this.radius = defaultRadius,
    this.elevation,
    this.animationCurve,
    this.animationDuration,
  })  : assert(
          filledColor == null || gradient == null,
          "You can't use filledColor and gradient at the same time",
        ),
        assert(
          gradient == null || (animationCurve == null && animationDuration == null),
          "You can't use gradient together with animationCurve or animationDuration",
        ),
        assert(
          (animationCurve == null && animationDuration == null) || gradient == null,
          "You can't use animationCurve or animationDuration together with gradient",
        );

  /// An optional icon to display before the child widget.
  final Widget? icon;

  /// An optional icon to display after the child widget.
  final Widget? suffixIcon;

  /// Defines the size of the button.
  final CButtonSize size;

  /// Padding between the leading icon and the text.
  final double iconPadding;

  /// Padding between the text and the suffix icon.
  final double suffixIconPadding;

  /// The color to fill the button with.
  final Color? filledColor;

  /// The color of the button's border.
  final Color? borderColor;

  /// The gradient to fill the button with.
  final LinearGradient? gradient;

  /// The radius of the button's corners.
  final Radius radius;

  /// Elevation (shadow) of the button. When null, uses [defaultButtonElevation].
  final double? elevation;

  /// Curve used for button animations (e.g. color changes).
  ///
  /// When null, [Curves.easeInOut] is used.
  final Curve? animationCurve;

  /// Duration used for button animations (e.g. color changes).
  ///
  /// When null, [Duration(milliseconds: 250)] is used.
  final Duration? animationDuration;

  CButtonDecoration copyWith({
    Widget? icon,
    Widget? suffixIcon,
    CButtonSize? size,
    double? iconPadding,
    double? suffixIconPadding,
    Color? filledColor,
    Color? borderColor,
    LinearGradient? gradient,
    Radius? radius,
    double? elevation,
    Curve? animationCurve,
    Duration? animationDuration,
  }) {
    return CButtonDecoration(
      icon: icon ?? this.icon,
      suffixIcon: suffixIcon ?? this.suffixIcon,
      size: size ?? this.size,
      iconPadding: iconPadding ?? this.iconPadding,
      suffixIconPadding: suffixIconPadding ?? this.suffixIconPadding,
      filledColor: filledColor ?? this.filledColor,
      borderColor: borderColor ?? this.borderColor,
      gradient: gradient ?? this.gradient,
      radius: radius ?? this.radius,
      elevation: elevation ?? this.elevation,
      animationCurve: animationCurve ?? this.animationCurve,
      animationDuration: animationDuration ?? this.animationDuration,
    );
  }
}

/// A stylized button widget.
class CButton extends StatelessWidget {
  const CButton._({
    super.key,
    this.onPressed,
    required this.child,
    this.decoration = const CButtonDecoration(),
  });

  /// Function called when the button is pressed.
  final void Function()? onPressed;

  /// The widget to display as the button's child.
  final Widget child;

  /// The decoration properties for the button.
  final CButtonDecoration decoration;

  /// Factory constructor for creating a filled elevated [CButton].
  factory CButton.elevated({
    Key? key,
    void Function()? onPressed,
    required Widget child,
    Widget? icon,
    Widget? suffixIcon,
    double iconPadding = defaultIconPadding,
    double suffixIconPadding = defaultIconPadding,
    Color? color,
    LinearGradient? gradient,
    Radius radius = defaultRadius,
    double? elevation,
    Curve? animationCurve,
    Duration? animationDuration,
  }) {
    return CButton._(
      key: key,
      onPressed: onPressed,
      decoration: CButtonDecoration(
        filledColor: color,
        gradient: gradient,
        icon: icon,
        suffixIcon: suffixIcon,
        iconPadding: iconPadding,
        suffixIconPadding: suffixIconPadding,
        radius: radius,
        elevation: elevation,
        animationCurve: animationCurve,
        animationDuration: animationDuration,
      ),
      child: child,
    );
  }

  /// Factory constructor for creating an outlined [CButton].
  factory CButton.outlined({
    Key? key,
    void Function()? onPressed,
    required Widget child,
    Widget? icon,
    Widget? suffixIcon,
    double iconPadding = defaultIconPadding,
    double suffixIconPadding = defaultIconPadding,
    Color? color,
    Color? fillColor,
    Radius radius = defaultRadius,
    double? elevation,
    Curve? animationCurve,
    Duration? animationDuration,
  }) {
    return CButton._(
      key: key,
      onPressed: onPressed,
      decoration: CButtonDecoration(
        icon: icon,
        suffixIcon: suffixIcon,
        iconPadding: iconPadding,
        suffixIconPadding: suffixIconPadding,
        borderColor: color ?? CColors.primaryColor,
        filledColor: fillColor ?? Colors.white,
        radius: radius,
        elevation: elevation,
        animationCurve: animationCurve,
        animationDuration: animationDuration,
      ),
      child: child,
    );
  }

  /// Factory constructor for creating a text [CButton].
  factory CButton.text({
    Key? key,
    void Function()? onPressed,
    required Widget child,
    Widget? icon,
    Widget? suffixIcon,
    double iconPadding = defaultIconPadding,
    double suffixIconPadding = defaultIconPadding,
  }) {
    return CButton._(
      key: key,
      onPressed: onPressed,
      decoration: CButtonDecoration(
        icon: icon,
        suffixIcon: suffixIcon,
        iconPadding: iconPadding,
        suffixIconPadding: suffixIconPadding,
        filledColor: Colors.transparent,
        radius: defaultRadius,
        elevation: 0,
      ),
      child: child,
    );
  }

  CButton _copyWith({
    Key? key,
    void Function()? onPressed,
    Widget? child,
    CButtonDecoration? decoration,
  }) {
    return CButton._(
      key: key,
      onPressed: onPressed ?? this.onPressed,
      decoration: decoration ?? this.decoration,
      child: child ?? this.child,
    );
  }

  // Returns a copy of the button with extra small size decoration
  CButton get xSmall => _copyWith(decoration: decoration.copyWith(size: CButtonSize.xSmall));

  // Returns a copy of the button with small size decoration
  CButton get small => _copyWith(decoration: decoration.copyWith(size: CButtonSize.small));

  // Returns a copy of the button with medium size decoration
  CButton get medium => _copyWith(decoration: decoration.copyWith(size: CButtonSize.medium));

  // Returns a copy of the button with large size decoration
  CButton get large => _copyWith(decoration: decoration.copyWith(size: CButtonSize.large));

  // Returns a copy of the button with extra large size decoration
  CButton get xLarge => _copyWith(decoration: decoration.copyWith(size: CButtonSize.xlarge));

  // Returns a copy of the button with extra extra large size decoration
  CButton get xxLarge => _copyWith(decoration: decoration.copyWith(size: CButtonSize.xxLarge));

  @override
  Widget build(BuildContext context) {
    // Default text color from button background brightness (contrast color); child can override.
    final fillColor = decoration.filledColor ?? (decoration.gradient == null ? CColors.primaryColor : null);
    final luminance = fillColor != null && fillColor != Colors.transparent
        ? fillColor.computeLuminance()
        : (decoration.gradient != null ? decoration.gradient!.colors.map((c) => c.computeLuminance()).reduce((a, b) => a + b) / decoration.gradient!.colors.length : Colors.white.computeLuminance());
    final defaultTextColor = luminance > 0.5 ? CColors.primary : Colors.white;

    final hasGradient = decoration.gradient != null;

    // Effective animation configuration (fallback to defaults when null).
    final animationCurve = decoration.animationCurve ?? Curves.easeInOut;
    final animationDuration = decoration.animationDuration ?? const Duration(milliseconds: 250);

    final rowChildren = <Widget>[
      if (decoration.icon != null) decoration.icon!,
      if (decoration.icon != null) SizedBox(width: decoration.iconPadding),
      child,
      if (decoration.suffixIcon != null) SizedBox(width: decoration.suffixIconPadding),
      if (decoration.suffixIcon != null) decoration.suffixIcon!,
    ];
    final content = IconTheme(
      data: IconThemeData(color: defaultTextColor),
      child: DefaultTextStyle.merge(
        style: TextStyle(color: defaultTextColor),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: rowChildren,
        ),
      ),
    );

    final effectiveElevation = decoration.elevation ?? defaultButtonElevation;

    final button = hasGradient
        ? Material(
            elevation: effectiveElevation,
            borderRadius: BorderRadius.all(decoration.radius),
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.all(decoration.radius),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: decoration.gradient,
                  borderRadius: BorderRadius.all(decoration.radius),
                ),
                height: decoration.size.height,
                padding: const EdgeInsetsGeometry.symmetric(horizontal: 24),
                child: content,
              ),
            ),
          )
        : TweenAnimationBuilder<Color?>(
            tween: ColorTween(end: decoration.filledColor ?? CColors.primaryColor),
            duration: animationDuration,
            curve: animationCurve,
            builder: (context, filledColor, _) {
              return TweenAnimationBuilder<Color?>(
                tween: ColorTween(end: decoration.borderColor ?? CColors.primaryColor),
                duration: animationDuration,
                curve: animationCurve,
                builder: (context, borderColor, _) {
                  return ElevatedButton(
                    onPressed: onPressed,
                    style: ButtonStyle(
                      elevation: WidgetStateProperty.all(effectiveElevation),
                      shadowColor: WidgetStateProperty.all(Colors.black),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(decoration.radius),
                        ),
                      ),
                      overlayColor: WidgetStateProperty.all(
                        CColors.primaryColorLight.withValues(alpha: 0.2),
                      ),
                      backgroundColor: WidgetStateProperty.all(
                        filledColor ?? CColors.primaryColor,
                      ),
                      side: decoration.borderColor != null
                          ? WidgetStateProperty.all(
                              BorderSide(width: 2.0, color: borderColor ?? CColors.primaryColor),
                            )
                          : null,
                      minimumSize: WidgetStateProperty.all(
                        Size(0, decoration.size.height),
                      ),
                    ),
                    child: content,
                  );
                },
              );
            },
          );
    return button;
  }

  Color getContrastColorForGradient(List<Color> colors) {
    final avgLuminance = colors.map((c) => c.computeLuminance()).reduce((a, b) => a + b) / colors.length;
    return avgLuminance > 0.5 ? Colors.black : Colors.white;
  }
}
