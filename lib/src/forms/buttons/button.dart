import 'package:caravaggio_ui/src/theme.dart';
import 'package:flutter/material.dart';

/// [CButtonSize.small] set the button's height to 32.0.
/// Enumeration defining the size of a [CButton].
/// [CButtonSize.normal] set the button's height to 52.0.
enum CButtonSize {
  /// Represents a small-sized button.
  small,

  /// Represents a normal-sized button.
  normal;

  /// Returns the height of the button based on its size.
  double get height {
    switch (this) {
      case CButtonSize.small:
        return 32.0;
      case CButtonSize.normal:
        return 52.0;
    }
  }
}

/// Class defining the decoration properties for a [CButton].
class CButtonDecoration {
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
  final double radius;

  const CButtonDecoration({
    this.filled = false,
    this.bordered = false,
    this.size = CButtonSize.normal,
    this.filledColor,
    this.borderColor,
    this.gradient,
    this.radius = 15,
  })  : assert(filledColor == null || gradient == null, "You can't use filledColor and gradient at the same time"),
        assert(filled || filledColor == null, "You can't use filledColor without filled");
}

/// A stylized button widget.
class CButton extends StatelessWidget {
  /// Function called when the button is pressed.
  final void Function()? onPressed;

  /// The widget to display as the button's child.
  final Widget child;

  /// An optional icon to display before the child widget.
  final Widget? icon;

  /// An optional icon to display after the child widget.
  final Widget? suffixIcon;

  /// The decoration properties for the button.
  final CButtonDecoration decoration;

  const CButton._({
    Key? key,
    this.onPressed,
    required this.child,
    this.icon,
    this.suffixIcon,
    this.decoration = const CButtonDecoration(),
  }) : super(key: key);

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
      icon: icon,
      suffixIcon: suffixIcon,
      decoration: CButtonDecoration(
        filled: true,
        bordered: false,
        filledColor: color,
        gradient: gradient,
      ),
      child: child,
    );
  }

  /// Factory constructor for creating a small filled elevated [CButton].
  factory CButton.elevatedSmall({
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
      icon: icon,
      suffixIcon: suffixIcon,
      decoration: CButtonDecoration(
        filled: true,
        bordered: false,
        filledColor: color,
        gradient: gradient,
        size: CButtonSize.small,
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
  }) {
    return CButton._(
      key: key,
      onPressed: onPressed,
      icon: icon,
      suffixIcon: suffixIcon,
      decoration: CButtonDecoration(
        filled: false,
        bordered: true,
        filledColor: color,
      ),
      child: child,
    );
  }

  /// Factory constructor for creating a small outlined [CButton].
  factory CButton.outlinedSmall({
    Key? key,
    void Function()? onPressed,
    required Widget child,
    Widget? icon,
    Widget? suffixIcon,
    Color? color,
  }) {
    return CButton._(
      key: key,
      onPressed: onPressed,
      icon: icon,
      suffixIcon: suffixIcon,
      decoration: CButtonDecoration(
        filled: false,
        bordered: true,
        filledColor: color,
        size: CButtonSize.small,
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
      icon: icon,
      suffixIcon: suffixIcon,
      decoration: const CButtonDecoration(
        filled: false,
        bordered: false,
      ),
      child: child,
    );
  }

  /// Factory constructor for creating a small text [CButton].
  factory CButton.textSmall({
    Key? key,
    void Function()? onPressed,
    required Widget child,
    Widget? icon,
    Widget? suffixIcon,
  }) {
    return CButton._(
      key: key,
      onPressed: onPressed,
      icon: icon,
      suffixIcon: suffixIcon,
      decoration: const CButtonDecoration(
        filled: false,
        bordered: false,
        size: CButtonSize.small,
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(decoration.radius),
          ),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.all(0.0),
        ),
        side: decoration.bordered
            ? MaterialStateProperty.all(
                BorderSide(width: 2.0, color: decoration.borderColor ?? CaravaggioUI.instance.primaryColor),
              )
            : null,
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        foregroundColor: MaterialStateProperty.all(
          decoration.filled ? Colors.white : CaravaggioUI.instance.primaryColor,
        ),
        elevation: decoration.filled ? MaterialStateProperty.all(2) : MaterialStateProperty.all(0),
      ),
      child: Ink(
        decoration: decoration.filled
            ? BoxDecoration(
                color: decoration.filledColor ?? (decoration.gradient == null ? CaravaggioUI.instance.primaryColor : null),
                gradient: decoration.gradient,
                borderRadius: BorderRadius.all(Radius.circular(decoration.radius)),
              )
            : null,
        child: Container(
          constraints: BoxConstraints(
            minHeight: (decoration.size).height,
          ), // min sizes for Material buttons
          alignment: Alignment.center,
          child: icon == null && suffixIcon == null
              ? child
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (suffixIcon != null) suffixIcon!,
                    child,
                    if (icon != null) icon!,
                  ],
                ),
        ),
      ),
    );
  }
}
