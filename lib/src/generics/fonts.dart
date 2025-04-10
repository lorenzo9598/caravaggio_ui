import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:flutter/material.dart';

enum TextType {
  /// Display text type
  display,

  /// Headline text type
  headline,

  /// Title text type
  title,

  /// Body text type
  body,

  /// Label text type
  label,
}

enum TextSize {
  /// Small display size
  small,

  /// Medium display size
  medium,

  /// Large display size
  large,
}

/// Extension methods for [TextStyle] related to Caravaggio UI theme.
class CText extends Text {
  final TextType type;
  final TextSize size;
  const CText._(
    super.data, {
    this.type = TextType.body,
    this.size = TextSize.medium,
    super.key,
    super.style,
    super.textAlign,
    super.textDirection,
    super.locale,
    super.softWrap,
    super.overflow,
    super.textScaleFactor,
    super.maxLines,
    super.semanticsLabel,
    super.textWidthBasis,
    super.strutStyle,
    super.textHeightBehavior,
  });

  factory CText.display(
    String data, {
    Key? key,
    TextStyle? style,
    TextSize? size,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    StrutStyle? strutStyle,
    TextHeightBehavior? textHeightBehavior,
  }) {
    return CText._(
      data,
      key: key,
      type: TextType.display,
      size: size ?? TextSize.medium,
      style: style,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      strutStyle: strutStyle,
      textHeightBehavior: textHeightBehavior,
    );
  }

  factory CText.headline(
    String data, {
    Key? key,
    TextStyle? style,
    TextSize? size,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    StrutStyle? strutStyle,
    TextHeightBehavior? textHeightBehavior,
  }) {
    return CText._(
      data,
      key: key,
      type: TextType.headline,
      size: size ?? TextSize.medium,
      style: style,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      strutStyle: strutStyle,
      textHeightBehavior: textHeightBehavior,
    );
  }

  factory CText.title(
    String data, {
    Key? key,
    TextStyle? style,
    TextSize? size,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    StrutStyle? strutStyle,
    TextHeightBehavior? textHeightBehavior,
  }) {
    return CText._(
      data,
      key: key,
      type: TextType.title,
      size: size ?? TextSize.medium,
      style: style,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      strutStyle: strutStyle,
      textHeightBehavior: textHeightBehavior,
    );
  }

  factory CText.body(
    String data, {
    Key? key,
    TextStyle? style,
    TextSize? size,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    StrutStyle? strutStyle,
    TextHeightBehavior? textHeightBehavior,
  }) {
    return CText._(
      data,
      key: key,
      type: TextType.body,
      size: size ?? TextSize.medium,
      style: style,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      strutStyle: strutStyle,
      textHeightBehavior: textHeightBehavior,
    );
  }

  factory CText.label(
    String data, {
    Key? key,
    TextStyle? style,
    TextSize? size,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    StrutStyle? strutStyle,
    TextHeightBehavior? textHeightBehavior,
  }) {
    return CText._(
      data,
      key: key,
      type: TextType.label,
      size: size ?? TextSize.medium,
      style: style,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      strutStyle: strutStyle,
      textHeightBehavior: textHeightBehavior,
    );
  }

  /// Applies primary light color to the current text style.
  CText get primaryLight => copyWith(style: style?.copyWith(color: CaravaggioUI.instance.primaryColorLight) ?? TextStyle(color: CaravaggioUI.instance.primaryColorLight));

  /// Applies primary color to the current text style.
  CText get primary => copyWith(style: style?.copyWith(color: CaravaggioUI.instance.primaryColor) ?? TextStyle(color: CaravaggioUI.instance.primaryColor));

  /// Applies primary dark color to the current text style.
  CText get primaryDark => copyWith(style: style?.copyWith(color: CaravaggioUI.instance.primaryColorDark) ?? TextStyle(color: CaravaggioUI.instance.primaryColorDark));

  /// Applies secondary color to the current text style.
  CText get secondary => copyWith(style: style?.copyWith(color: CaravaggioUI.instance.secondaryColor) ?? TextStyle(color: CaravaggioUI.instance.secondaryColor));

  /// Applies secondary light color to the current text style.
  CText get secondaryLight => copyWith(style: style?.copyWith(color: CaravaggioUI.instance.secondaryColorLight) ?? TextStyle(color: CaravaggioUI.instance.secondaryColorLight));

  /// Applies secondary dark color to the current text style.
  CText get secondaryDark => copyWith(style: style?.copyWith(color: CaravaggioUI.instance.secondaryColorDark) ?? TextStyle(color: CaravaggioUI.instance.secondaryColorDark));

  /// Applies white color to the current text style.
  CText get white => copyWith(style: style?.copyWith(color: Colors.white) ?? const TextStyle(color: Colors.white));

  /// Applies bold font weight to the current text style.
  CText get bold => copyWith(style: style?.copyWith(fontWeight: FontWeight.bold) ?? const TextStyle(fontWeight: FontWeight.bold));

  /// Applies italic font style to the current text style.
  CText get italic => copyWith(style: style?.copyWith(fontStyle: FontStyle.italic) ?? const TextStyle(fontStyle: FontStyle.italic));

  /// Creates a copy of this text with the given fields replaced with the new values.
  CText copyWith({
    String? data,
    TextStyle? style,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    StrutStyle? strutStyle,
    TextHeightBehavior? textHeightBehavior,
  }) {
    return CText._(
      data ?? this.data!,
      key: key,
      style: style ?? this.style,
      textAlign: textAlign ?? this.textAlign,
      textDirection: textDirection ?? this.textDirection,
      locale: locale ?? this.locale,
      softWrap: softWrap ?? this.softWrap,
      overflow: overflow ?? this.overflow,
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
      maxLines: maxLines ?? this.maxLines,
      semanticsLabel: semanticsLabel ?? this.semanticsLabel,
      textWidthBasis: textWidthBasis ?? this.textWidthBasis,
      strutStyle: strutStyle ?? this.strutStyle,
      textHeightBehavior: textHeightBehavior ?? this.textHeightBehavior,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Usa ThemeData.light() per stili sicuri e coerenti con Material Design
    final baseTheme = Theme.of(context).textTheme;

    final TextStyle? baseStyle = switch (type) {
      TextType.display => switch (size) {
          TextSize.small => baseTheme.displaySmall,
          TextSize.medium => baseTheme.displayMedium,
          TextSize.large => baseTheme.displayLarge,
        },
      TextType.headline => switch (size) {
          TextSize.small => baseTheme.titleSmall,
          TextSize.medium => baseTheme.titleMedium,
          TextSize.large => baseTheme.titleLarge,
        },
      TextType.title => switch (size) {
          TextSize.small => baseTheme.titleSmall,
          TextSize.medium => baseTheme.titleMedium,
          TextSize.large => baseTheme.titleLarge,
        },
      TextType.body => switch (size) {
          TextSize.small => baseTheme.titleSmall,
          TextSize.medium => baseTheme.titleMedium,
          TextSize.large => baseTheme.titleLarge,
        },
      TextType.label => switch (size) {
          TextSize.small => baseTheme.titleSmall,
          TextSize.medium => baseTheme.titleMedium,
          TextSize.large => baseTheme.titleLarge,
        },
    };

    // Unisce lo stile personalizzato (se presente) con quello base
    final mergedStyle = baseStyle?.merge(style) ?? baseStyle;
    return Text(
      data!,
      key: key,
      style: mergedStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      strutStyle: strutStyle,
      textHeightBehavior: textHeightBehavior,
    );
  }
}
