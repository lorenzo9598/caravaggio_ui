import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui_app/widgets/demo_page_navigation.dart';
import 'package:flutter/material.dart';

const double _cardPadding = 16.0;
const double sectionSpacing = 4.0;
const double _itemSpacing = 16.0;
const double _sectionIconGap = 10.0;

class Sections extends StatelessWidget {
  final List<Section> sections;
  final EdgeInsets? padding;

  const Sections({
    super.key,
    required this.sections,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final basePadding = padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
    final scrollPadding = DemoNavScope.maybeOf(context) != null
        ? basePadding.copyWith(
            bottom: basePadding.bottom + DemoPageNavigation.bottomInset(context),
          )
        : basePadding;

    return SingleChildScrollView(
      padding: scrollPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (int i = 0; i < sections.length; i++) ...[
            sections[i],
            if (i != sections.length - 1) const SizedBox(height: sectionSpacing),
          ],
        ],
      ),
    );
  }
}

class Section extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<(String label, Widget content)> items;
  const Section({
    super.key,
    required this.title,
    required this.icon,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: sectionSpacing),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.all(AppRadius.m),
        boxShadow: AppShadow.xs,
      ),
      child: Theme(
        data: theme.copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(AppRadius.m),
          ),
          collapsedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(AppRadius.m),
          ),
          iconColor: CColors.primaryColor,
          collapsedIconColor: theme.iconTheme.color,
          title: Row(
            children: [
              CIconBadge(icon: icon),
              const SizedBox(width: _sectionIconGap),
              Expanded(child: CText.title(title)),
            ],
          ),
          children: [
            ...items.map(
              (item) => Padding(
                padding: EdgeInsets.only(
                  bottom: items.indexOf(item) < items.length - 1 ? _itemSpacing : 0,
                ),
                child: Card(label: item.$1, content: item.$2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Card extends StatelessWidget {
  final String label;
  final Widget content;
  const Card({
    super.key,
    required this.label,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_cardPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(AppRadius.m),
        boxShadow: AppShadow.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CText.label(
            label,
            size: TextSize.small,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 12),
          Center(child: content),
        ],
      ),
    );
  }
}
