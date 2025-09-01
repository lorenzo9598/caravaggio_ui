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

class CTextStyle {
  final TextType type;
  final TextSize size;

  const CTextStyle._(this.type, this.size);

  const CTextStyle.displayLarge()
      : type = TextType.display,
        size = TextSize.large;

  const CTextStyle.displayMedium()
      : type = TextType.display,
        size = TextSize.medium;

  const CTextStyle.displaySmall()
      : type = TextType.display,
        size = TextSize.small;

  const CTextStyle.headlineLarge()
      : type = TextType.headline,
        size = TextSize.large;

  const CTextStyle.headlineMedium()
      : type = TextType.headline,
        size = TextSize.medium;

  const CTextStyle.headlineSmall()
      : type = TextType.headline,
        size = TextSize.small;

  const CTextStyle.titleLarge()
      : type = TextType.title,
        size = TextSize.large;

  const CTextStyle.titleMedium()
      : type = TextType.title,
        size = TextSize.medium;

  const CTextStyle.titleSmall()
      : type = TextType.title,
        size = TextSize.small;

  const CTextStyle.bodyLarge()
      : type = TextType.body,
        size = TextSize.large;

  const CTextStyle.bodyMedium()
      : type = TextType.body,
        size = TextSize.medium;

  const CTextStyle.bodySmall()
      : type = TextType.body,
        size = TextSize.small;

  const CTextStyle.labelLarge()
      : type = TextType.label,
        size = TextSize.large;

  const CTextStyle.labelMedium()
      : type = TextType.label,
        size = TextSize.medium;

  const CTextStyle.labelSmall()
      : type = TextType.label,
        size = TextSize.small;
}

/// Extension methods for [TextStyle] related to Caravaggio UI theme.
class CText extends StatelessWidget {
  final String? data;
  final TextType type;
  final TextSize size;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final StrutStyle? strutStyle;
  final TextHeightBehavior? textHeightBehavior;

  // Deltas applicati *dopo* il merge con il tema
  final List<TextStyle> _overrides;

  const CText._(
    this.data, {
    List<TextStyle>? overrides,
    super.key,
    this.type = TextType.body,
    this.size = TextSize.medium,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.strutStyle,
    this.textHeightBehavior,
  }) : _overrides = overrides ?? const [];

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
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      strutStyle: strutStyle,
      textHeightBehavior: textHeightBehavior,
    );
  }

  /// Applies primary light color to the current text style.
  CText get primaryLight => _withOverride(TextStyle(color: CaravaggioUI.instance.primaryColorLight));

  /// Applies primary color to the current text style.
  // CText get primary => copyWith(style: style?.copyWith(color: CaravaggioUI.instance.primaryColor) ?? TextStyle(color: CaravaggioUI.instance.primaryColor));
  CText get primary => _withOverride(TextStyle(color: CaravaggioUI.instance.primary));

  /// Applies primary dark color to the current text style.
  CText get primaryDark => copyWith(style: style?.copyWith(color: CaravaggioUI.instance.primaryColorDark) ?? TextStyle(color: CaravaggioUI.instance.primaryColorDark));

  /// Applies secondary color to the current text style.
  // CText get secondary => copyWith(style: style?.copyWith(color: CaravaggioUI.instance.secondaryColor) ?? TextStyle(color: CaravaggioUI.instance.secondaryColor));
  CText get secondary => _withOverride(TextStyle(color: CaravaggioUI.instance.secondaryColor));

  /// Applies secondary light color to the current text style.
  CText get secondaryLight => copyWith(style: style?.copyWith(color: CaravaggioUI.instance.secondaryColorLight) ?? TextStyle(color: CaravaggioUI.instance.secondaryColorLight));

  /// Applies secondary dark color to the current text style.
  CText get secondaryDark => copyWith(style: style?.copyWith(color: CaravaggioUI.instance.secondaryColorDark) ?? TextStyle(color: CaravaggioUI.instance.secondaryColorDark));

  /// Applies white color to the current text style.
  CText get white => copyWith(style: style?.copyWith(color: Colors.white) ?? const TextStyle(color: Colors.white));

  /// Applies italic font style to the current text style.
  CText get italic => _withOverride(const TextStyle(fontStyle: FontStyle.italic));

  /// Applies bold font weight to the current text style.
  CText get bold => _withOverride(const TextStyle(fontWeight: FontWeight.bold));

  /// Applies underline decoration to the current text style.
  CText get underline => _withOverride(const TextStyle(decoration: TextDecoration.underline));

  // Quick setters (chaining)

  /// Sets the color of the text.
  CText withColor(Color c) => _withOverride(TextStyle(color: c));

  /// Sets the font size of the text.
  CText withSize(double s) => _withOverride(TextStyle(fontSize: s));

  /// Sets the font weight of the text.
  CText withWeight(FontWeight w) => _withOverride(TextStyle(fontWeight: w));

  // Duplica il widget aggiungendo un override in coda (l’ultimo vince)
  CText _withOverride(TextStyle delta) {
    return CText._(
      data,
      size: size,
      type: type,
      style: style,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      strutStyle: strutStyle,
      textHeightBehavior: textHeightBehavior,
      overrides: [..._overrides, delta],
      key: key,
    );
  }

  /// Creates a copy of this text with the given fields replaced with the new values.
  CText copyWith({
    String? data,
    TextStyle? style,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
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
      maxLines: maxLines ?? this.maxLines,
      semanticsLabel: semanticsLabel ?? this.semanticsLabel,
      textWidthBasis: textWidthBasis ?? this.textWidthBasis,
      strutStyle: strutStyle ?? this.strutStyle,
      textHeightBehavior: textHeightBehavior ?? this.textHeightBehavior,
    );
  }

  TextStyle? mergedStyle(context) {
    final baseTheme = Theme.of(context).textTheme;

    final TextStyle? baseStyle = switch (type) {
      TextType.display => switch (size) {
          TextSize.small => baseTheme.displaySmall,
          TextSize.medium => baseTheme.displayMedium,
          TextSize.large => baseTheme.displayLarge,
        },
      TextType.headline => switch (size) {
          TextSize.small => baseTheme.headlineSmall,
          TextSize.medium => baseTheme.headlineMedium,
          TextSize.large => baseTheme.headlineLarge,
        },
      TextType.title => switch (size) {
          TextSize.small => baseTheme.titleSmall,
          TextSize.medium => baseTheme.titleMedium,
          TextSize.large => baseTheme.titleLarge,
        },
      TextType.body => switch (size) {
          TextSize.small => baseTheme.bodySmall,
          TextSize.medium => baseTheme.bodyMedium,
          TextSize.large => baseTheme.bodyLarge,
        },
      TextType.label => switch (size) {
          TextSize.small => baseTheme.labelSmall,
          TextSize.medium => baseTheme.labelMedium,
          TextSize.large => baseTheme.labelLarge,
        },
    };

    // Unisce lo stile personalizzato (se presente) con quello base
    TextStyle? mergedStyle = baseStyle?.merge(style) ?? baseStyle;

    for (final delta in _overrides) {
      mergedStyle = mergedStyle?.merge(delta);
    }

    return mergedStyle;
  }

  @override
  Widget build(BuildContext context) {
    // Usa ThemeData.light() per stili sicuri e coerenti con Material Design

    return Text(
      data!,
      key: key,
      style: mergedStyle(context),
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      strutStyle: strutStyle,
      textHeightBehavior: textHeightBehavior,
    );
  }
}
