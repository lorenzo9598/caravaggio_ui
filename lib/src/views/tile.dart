import 'package:caravaggio_ui/src/generics/fonts.dart';
import 'package:caravaggio_ui/src/utils/app_radius.dart';
import 'package:caravaggio_ui/src/utils/app_shadow.dart';
import 'package:caravaggio_ui/src/views/icon_badge.dart';
import 'package:caravaggio_ui/src/views/tag_chip.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Caravaggio list/modal tile with leading, center slots, and optional trailing.
class CTile extends StatelessWidget {
  const CTile({
    super.key,
    this.leading,
    this.header,
    this.content,
    this.footer,
    this.tags = const [],
    this.trailing,
    this.onTap,
    this.backgroundColor,
    this.borderRadius = const BorderRadius.all(AppRadius.m),
    this.padding = const EdgeInsets.all(16),
    this.dateTime,
  });

  static const double _leadingGap = 12;
  static const double _centerBlockGap = 8;
  static const double _titleDescriptionGap = 4;
  static const double _tagsSpacing = 6;
  static const double _trailingGap = 8;
  static const double _borderColorAlpha = 0.2;

  static double _hairlineBorderWidth(BuildContext context) {
    return 1 / MediaQuery.devicePixelRatioOf(context);
  }

  final Widget? leading;
  final Widget? header;
  final Widget? content;
  final Widget? footer;
  final List<Widget> tags;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final BorderRadius borderRadius;
  final EdgeInsets padding;

  /// When set, shown on the right of the header row (used by [withDateTime]).
  final DateTime? dateTime;

  /// Title, description, optional tags, and optional [CIconBadge] leading.
  factory CTile.simple({
    Key? key,
    required String title,
    String? description,
    List<String> tags = const [],
    IconData? icon,
    Widget? leading,
    String? footer,
    VoidCallback? onTap,
    Color? backgroundColor,
    BorderRadius borderRadius = const BorderRadius.all(AppRadius.m),
    EdgeInsets padding = const EdgeInsets.all(16),
    Widget? trailing,
  }) {
    return CTile(
      key: key,
      leading: _resolveLeading(icon: icon, leading: leading),
      content: _buildSimpleContent(title: title, description: description),
      footer: footer != null ? CText.body(footer, size: TextSize.small) : null,
      tags: _buildStringTags(tags),
      onTap: onTap,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      padding: padding,
      trailing: trailing,
    );
  }

  /// [simple] with [dateTime] formatted in the header row (top right).
  factory CTile.withDateTime({
    Key? key,
    required String title,
    required DateTime dateTime,
    String? description,
    List<String> tags = const [],
    IconData? icon,
    Widget? leading,
    String? footer,
    VoidCallback? onTap,
    Color? backgroundColor,
    BorderRadius borderRadius = const BorderRadius.all(AppRadius.m),
    EdgeInsets padding = const EdgeInsets.all(16),
    Widget? trailing,
  }) {
    return CTile(
      key: key,
      leading: _resolveLeading(icon: icon, leading: leading),
      content: _buildSimpleContent(title: title, description: description),
      footer: footer != null ? CText.body(footer, size: TextSize.small) : null,
      tags: _buildStringTags(tags),
      dateTime: dateTime,
      onTap: onTap,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      padding: padding,
      trailing: trailing,
    );
  }

  /// Icon, title, and optional description without tags or footer.
  factory CTile.icon({
    Key? key,
    required IconData icon,
    required String title,
    String? description,
    VoidCallback? onTap,
    Color? backgroundColor,
    BorderRadius borderRadius = const BorderRadius.all(AppRadius.m),
    EdgeInsets padding = const EdgeInsets.all(16),
    Widget? trailing,
  }) {
    return CTile(
      key: key,
      leading: CIconBadge(icon: icon),
      content: _buildSimpleContent(title: title, description: description),
      onTap: onTap,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      padding: padding,
      trailing: trailing,
    );
  }

  static Widget? _resolveLeading({IconData? icon, Widget? leading}) {
    if (leading != null) {
      return leading;
    }
    if (icon != null) {
      return CIconBadge(icon: icon);
    }
    return null;
  }

  static Widget _buildSimpleContent({
    required String title,
    String? description,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CText.title(title, size: TextSize.medium),
        if (description != null) ...[
          const SizedBox(height: _titleDescriptionGap),
          CText.body(description, size: TextSize.small),
        ],
      ],
    );
  }

  static List<Widget> _buildStringTags(List<String> tags) {
    return tags.map((tag) => CTagChip(label: tag)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final surfaceColor = backgroundColor ?? theme.cardColor;
    final borderColor = theme.dividerColor.withValues(alpha: _borderColorAlpha);
    final borderWidth = _hairlineBorderWidth(context);

    final tileBody = Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: _leadingGap),
          ],
          Expanded(child: _buildCenterColumn(context)),
          if (_buildTrailing(context) != null) ...[
            const SizedBox(width: _trailingGap),
            _buildTrailing(context)!,
          ],
        ],
      ),
    );

    final decorated = Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: borderRadius,
        border: Border.all(color: borderColor, width: borderWidth),
        boxShadow: AppShadow.sm,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: onTap != null
            ? Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                  child: tileBody,
                ),
              )
            : tileBody,
      ),
    );

    return decorated;
  }

  Widget _buildCenterColumn(BuildContext context) {
    final children = <Widget>[];

    final headerRow = _buildHeaderRow(context);
    if (headerRow != null) {
      children.add(headerRow);
    }

    if (content != null) {
      if (children.isNotEmpty) {
        children.add(const SizedBox(height: _centerBlockGap));
      }
      children.add(content!);
    }

    if (footer != null) {
      if (children.isNotEmpty) {
        children.add(const SizedBox(height: _centerBlockGap));
      }
      children.add(footer!);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  Widget? _buildHeaderRow(BuildContext context) {
    final hasHeader = header != null;
    final hasTags = tags.isNotEmpty && header == null;
    final hasDateTime = dateTime != null;

    if (!hasHeader && !hasTags && !hasDateTime) {
      return null;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: hasHeader
              ? header!
              : hasTags
                  ? Wrap(
                      spacing: _tagsSpacing,
                      runSpacing: _tagsSpacing,
                      children: tags,
                    )
                  : const SizedBox.shrink(),
        ),
        if (hasDateTime) ...[
          const SizedBox(width: _leadingGap),
          _buildDateTimeLabel(context),
        ],
      ],
    );
  }

  Widget _buildDateTimeLabel(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final formatted = DateFormat('d MMM y · HH:mm', locale).format(dateTime!);

    return CText.label(
      formatted,
      size: TextSize.small,
      style: TextStyle(
        color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.7),
      ),
    );
  }

  Widget? _buildTrailing(BuildContext context) {
    if (onTap == null) {
      return null;
    }

    if (trailing != null) {
      return trailing;
    }

    return Icon(
      Icons.chevron_right,
      color: Theme.of(context).iconTheme.color?.withValues(alpha: 0.45),
    );
  }
}
