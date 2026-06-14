import 'package:caravaggio_ui/src/generics/fonts.dart';
import 'package:caravaggio_ui/src/generics/gradients.dart';
import 'package:caravaggio_ui/src/utils/app_radius.dart';
import 'package:caravaggio_ui/src/utils/app_shadow.dart';
import 'package:caravaggio_ui/src/views/tag_chip.dart';
import 'package:flutter/material.dart';

/// Caravaggio card for carousel layouts with image, gradient, or solid header.
class CCarousel extends StatelessWidget {
  const CCarousel._({
    super.key,
    required bool overlay,
    required this.width,
    required this.title,
    this.aspectRatio = 16 / 9,
    this.backgroundColor,
    this.image,
    this.gradient,
    this.color,
    this.subtitle,
    this.description,
    this.bottom,
    this.tags = const [],
    this.onTap,
    this.borderRadius = const BorderRadius.all(AppRadius.l),
  })  : _overlay = overlay,
        assert(
          (image != null ? 1 : 0) + (gradient != null ? 1 : 0) + (color != null ? 1 : 0) <= 1,
          'At most one of image, gradient, or color can be provided.',
        );

  static const double _contentPadding = 16;
  static const double _tagsPadding = 12;
  static const double _titleSubtitleGap = 4;
  static const double _contentBlockGap = 8;
  static const double _overlayScrimAlpha = 0.75;

  final bool _overlay;
  final double width;
  final double aspectRatio;
  final Color? backgroundColor;
  final Widget? image;
  final LinearGradient? gradient;
  final Color? color;
  final Widget title;
  final Widget? subtitle;
  final Widget? description;
  final Widget? bottom;
  final List<Widget> tags;
  final VoidCallback? onTap;
  final BorderRadius borderRadius;

  /// Header on top, content below with [backgroundColor].
  factory CCarousel.stacked({
    Key? key,
    required double width,
    required Widget title,
    double aspectRatio = 16 / 9,
    Color? backgroundColor,
    Widget? image,
    LinearGradient? gradient,
    Color? color,
    Widget? subtitle,
    Widget? description,
    Widget? bottom,
    List<Widget> tags = const [],
    VoidCallback? onTap,
    BorderRadius borderRadius = const BorderRadius.all(AppRadius.l),
  }) {
    return CCarousel._(
      key: key,
      overlay: false,
      width: width,
      aspectRatio: aspectRatio,
      backgroundColor: backgroundColor,
      image: image,
      gradient: gradient,
      color: color,
      title: title,
      subtitle: subtitle,
      description: description,
      bottom: bottom,
      tags: tags,
      onTap: onTap,
      borderRadius: borderRadius,
    );
  }

  /// Full-bleed header with content overlaid at the bottom and a bottom scrim.
  factory CCarousel.overlay({
    Key? key,
    required double width,
    required Widget title,
    double aspectRatio = 16 / 9,
    Color? backgroundColor,
    Widget? image,
    LinearGradient? gradient,
    Color? color,
    Widget? subtitle,
    Widget? description,
    Widget? bottom,
    List<Widget> tags = const [],
    VoidCallback? onTap,
    BorderRadius borderRadius = const BorderRadius.all(AppRadius.l),
  }) {
    return CCarousel._(
      key: key,
      overlay: true,
      width: width,
      aspectRatio: aspectRatio,
      backgroundColor: backgroundColor,
      image: image,
      gradient: gradient,
      color: color,
      title: title,
      subtitle: subtitle,
      description: description,
      bottom: bottom,
      tags: tags,
      onTap: onTap,
      borderRadius: borderRadius,
    );
  }

  /// [stacked] with string slots and optional [ImageProvider] header image.
  factory CCarousel.stackedSimple({
    Key? key,
    required double width,
    required String title,
    double aspectRatio = 16 / 9,
    Color? backgroundColor,
    ImageProvider? image,
    BoxFit boxFit = BoxFit.cover,
    LinearGradient? gradient,
    Color? color,
    String? subtitle,
    String? description,
    List<String> tags = const [],
    Widget? bottom,
    VoidCallback? onTap,
    BorderRadius borderRadius = const BorderRadius.all(AppRadius.l),
  }) {
    return CCarousel.stacked(
      key: key,
      width: width,
      aspectRatio: aspectRatio,
      backgroundColor: backgroundColor,
      image: image != null ? _buildImageWidget(image, boxFit) : null,
      gradient: gradient,
      color: color,
      title: CText.title(title, size: TextSize.medium),
      subtitle: subtitle != null ? CText.body(subtitle, size: TextSize.small) : null,
      description: description != null ? CText.body(description, size: TextSize.small) : null,
      bottom: bottom,
      tags: _buildSimpleTags(tags, overlay: false),
      onTap: onTap,
      borderRadius: borderRadius,
    );
  }

  /// [overlay] with string slots and optional [ImageProvider] header image.
  factory CCarousel.overlaySimple({
    Key? key,
    required double width,
    required String title,
    double aspectRatio = 16 / 9,
    Color? backgroundColor,
    ImageProvider? image,
    BoxFit boxFit = BoxFit.cover,
    LinearGradient? gradient,
    Color? color,
    String? subtitle,
    String? description,
    List<String> tags = const [],
    Widget? bottom,
    VoidCallback? onTap,
    BorderRadius borderRadius = const BorderRadius.all(AppRadius.l),
  }) {
    const lightText = TextStyle(color: Colors.white);

    return CCarousel.overlay(
      key: key,
      width: width,
      aspectRatio: aspectRatio,
      backgroundColor: backgroundColor,
      image: image != null ? _buildImageWidget(image, boxFit) : null,
      gradient: gradient,
      color: color,
      title: CText.title(title, size: TextSize.medium, style: lightText),
      subtitle: subtitle != null
          ? CText.body(subtitle, size: TextSize.small, style: lightText)
          : null,
      description: description != null
          ? CText.body(description, size: TextSize.small, style: lightText)
          : null,
      bottom: bottom,
      tags: _buildSimpleTags(tags, overlay: true),
      onTap: onTap,
      borderRadius: borderRadius,
    );
  }

  static Widget _buildImageWidget(ImageProvider image, BoxFit boxFit) {
    return Image(
      image: image,
      fit: boxFit,
      width: double.infinity,
      height: double.infinity,
    );
  }

  static List<Widget> _buildSimpleTags(List<String> tags, {required bool overlay}) {
    return tags
        .map(
          (tag) => CTagChip(
            label: tag,
            variant: overlay ? CTagChipVariant.overlay : CTagChipVariant.normal,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final card = _overlay ? _buildOverlay(context) : _buildStacked(context);

    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: AppShadow.sm,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: _wrapTapTarget(card),
      ),
    );
  }

  Widget _wrapTapTarget(Widget child) {
    if (onTap == null) {
      return child;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: child,
      ),
    );
  }

  Widget _buildStacked(BuildContext context) {
    final contentBackground = backgroundColor ?? Theme.of(context).colorScheme.surface;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(
          aspectRatio: aspectRatio,
          child: _buildHeaderStack(),
        ),
        Container(
          color: contentBackground,
          padding: const EdgeInsets.all(_contentPadding),
          child: _buildContentColumn(),
        ),
      ],
    );
  }

  Widget _buildOverlay(BuildContext context) {
    final cardHeight = width / aspectRatio;
    final scrimBase = backgroundColor ?? Colors.black;

    return SizedBox(
      width: width,
      height: cardHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _buildHeaderBackground(),
          if (tags.isNotEmpty)
            Positioned(
              top: _tagsPadding,
              left: _tagsPadding,
              right: _tagsPadding,
              child: _buildTagsRow(),
            ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    scrimBase.withValues(alpha: _overlayScrimAlpha),
                    scrimBase.withValues(alpha: 0),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(_contentPadding),
                child: _buildContentColumn(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStack() {
    return Stack(
      fit: StackFit.expand,
      children: [
        _buildHeaderBackground(),
        if (tags.isNotEmpty)
          Positioned(
            top: _tagsPadding,
            left: _tagsPadding,
            right: _tagsPadding,
            child: _buildTagsRow(),
          ),
      ],
    );
  }

  Widget _buildHeaderBackground() {
    if (image != null) {
      return SizedBox.expand(child: image);
    }

    if (gradient != null) {
      return DecoratedBox(
        decoration: BoxDecoration(gradient: gradient),
      );
    }

    if (color != null) {
      return ColoredBox(color: color!);
    }

    return DecoratedBox(
      decoration: BoxDecoration(gradient: CGradient.primaryToSecondary),
    );
  }

  Widget _buildTagsRow() {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: tags,
    );
  }

  Widget _buildContentColumn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title,
        if (subtitle != null) ...[
          const SizedBox(height: _titleSubtitleGap),
          subtitle!,
        ],
        if (description != null) ...[
          const SizedBox(height: _contentBlockGap),
          description!,
        ],
        if (bottom != null) ...[
          const SizedBox(height: _contentBlockGap),
          bottom!,
        ],
      ],
    );
  }
}
