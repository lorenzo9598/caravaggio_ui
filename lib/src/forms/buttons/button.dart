import 'package:caravaggio_ui/src/themes/theme.dart';
import 'package:caravaggio_ui/src/utils/app_radius.dart';
import 'package:flutter/material.dart';

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
        return 32.0;
      case CButtonSize.medium:
        return 52.0;
      case CButtonSize.large:
        return 72.0; // Example value for large
      case CButtonSize.xlarge:
        return 92.0; // Example value for xlarge
      case CButtonSize.xxLarge:
        return 112.0; // Example value for xxLarge
    }
  }
}

/// Class defining the decoration properties for a [CButton].
class CButtonDecoration {
  const CButtonDecoration({
    this.icon,
    this.suffixIcon,
    this.filled = false,
    this.bordered = false,
    this.size = CButtonSize.medium,
    this.filledColor,
    this.borderColor,
    this.gradient,
    this.radius = AppRadius.m,
  })  : assert(filledColor == null || gradient == null, "You can't use filledColor and gradient at the same time"),
        assert(filled || filledColor == null, "You can't use filledColor without filled");

  /// An optional icon to display before the child widget.
  final Widget? icon;

  /// An optional icon to display after the child widget.
  final Widget? suffixIcon;

  /// Indicates whether the button is filled with color or not.
  final bool filled;

  /// Indicates whether the button has a border or not.
  final bool bordered;

  /// Defines the size of the button.
  final CButtonSize size;

  /// The color to fill the button with.
  final Color? filledColor;

  /// The color of the button's border.
  final Color? borderColor;

  /// The gradient to fill the button with.
  final LinearGradient? gradient;

  /// The radius of the button's corners.
  final Radius radius;

  CButtonDecoration copyWith({
    Widget? icon,
    Widget? suffixIcon,
    bool? filled,
    bool? bordered,
    CButtonSize? size,
    Color? filledColor,
    Color? borderColor,
    LinearGradient? gradient,
    Radius? radius,
  }) {
    return CButtonDecoration(
      icon: icon ?? this.icon,
      suffixIcon: suffixIcon ?? this.suffixIcon,
      filled: filled ?? this.filled,
      bordered: bordered ?? this.bordered,
      size: size ?? this.size,
      filledColor: filledColor ?? this.filledColor,
      borderColor: borderColor ?? this.borderColor,
      gradient: gradient ?? this.gradient,
      radius: radius ?? this.radius,
    );
  }
}

/// A stylized button widget.
class CButton extends StatelessWidget {
  const CButton._({
    Key? key,
    this.onPressed,
    required this.child,
    this.decoration = const CButtonDecoration(),
  }) : super(key: key);

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
    Color? color,
    LinearGradient? gradient,
  }) {
    return CButton._(
      key: key,
      onPressed: onPressed,
      decoration: CButtonDecoration(
        filled: true,
        bordered: false,
        filledColor: color,
        gradient: gradient,
        icon: icon,
        suffixIcon: suffixIcon,
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
    Color? color,
    Color? fillColor,
  }) {
    return CButton._(
      key: key,
      onPressed: onPressed,
      decoration: CButtonDecoration(
        icon: icon,
        suffixIcon: suffixIcon,
        filled: fillColor != null,
        bordered: true,
        borderColor: color,
        filledColor: fillColor,
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
  }) {
    return CButton._(
      key: key,
      onPressed: onPressed,
      decoration: CButtonDecoration(
        icon: icon,
        suffixIcon: suffixIcon,
        filled: false,
        bordered: false,
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
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(decoration.radius),
          ),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.all(0.0),
        ),
        side: decoration.bordered
            ? WidgetStateProperty.all(
                BorderSide(width: 2.0, color: decoration.borderColor ?? CaravaggioUI.instance.primaryColor),
              )
            : null,
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        foregroundColor: WidgetStateProperty.all(
          decoration.filled ? Colors.white : CaravaggioUI.instance.primaryColor,
        ),
        elevation: decoration.filled
            ? WidgetStateProperty.resolveWith<double>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.pressed)) {
                    return 8.0; // Elevation when the button is pressed
                  }
                  return decoration.size.height / 10; // Dynamic elevation based on button height
                },
              )
            : WidgetStateProperty.all(0),
        minimumSize: WidgetStateProperty.all(
          Size(double.infinity, decoration.size.height),
        ),
      ),
      child: Ink(
        decoration: decoration.filled
            ? BoxDecoration(
                color: decoration.filledColor ?? (decoration.gradient == null ? CaravaggioUI.instance.primaryColor : null),
                gradient: decoration.gradient,
                borderRadius: BorderRadius.all(decoration.radius),
              )
            : null,
        child: Container(
          constraints: BoxConstraints(
            minHeight: (decoration.size).height,
          ), // min sizes for Material buttons
          alignment: Alignment.center,
          child: decoration.icon == null && decoration.suffixIcon == null
              ? child
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (decoration.suffixIcon != null) decoration.suffixIcon!,
                    child,
                    if (decoration.icon != null) decoration.icon!,
                  ],
                ),
        ),
      ),
    );
  }
}
