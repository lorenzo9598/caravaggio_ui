import 'package:caravaggio_ui/src/themes/theme.dart';
import 'package:caravaggio_ui/src/utils/app_radius.dart';
import 'package:caravaggio_ui/src/utils/app_spacing.dart';
import 'package:flutter/material.dart';

/// One destination in a [CBottomBar].
class CBottomBarItem {
  /// Creates a bottom-bar destination.
  const CBottomBarItem({
    required this.icon,
    required this.label,
    this.selectedIcon,
  });

  /// Icon shown when this destination is not selected.
  final IconData icon;

  /// Icon shown when this destination is selected.
  ///
  /// Falls back to [icon] when null.
  final IconData? selectedIcon;

  /// Short label under the icon. Kept to one line.
  final String label;
}

/// Bottom navigation bar for the app shell.
///
/// Pass it to CScaffold via the `bottomBar` parameter. Two to five items. The bar does not
/// change routes by itself: [onTap] reports the tapped index and the parent
/// owns [currentIndex].
class CBottomBar extends StatelessWidget {
  /// Creates a bottom bar.
  const CBottomBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  })  : assert(
          items.length >= 2 && items.length <= 5,
          'CBottomBar accepts 2 to 5 items',
        ),
        assert(
          currentIndex >= 0 && currentIndex < items.length,
          'currentIndex is out of range',
        );

  /// Destinations, from left to right.
  final List<CBottomBarItem> items;

  /// Index of the selected destination.
  final int currentIndex;

  /// Called with the index of the tapped destination.
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 8,
      shadowColor: CColors.primaryColor.withValues(alpha: 0.16),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.sm,
            AppSpacing.xs,
            AppSpacing.sm,
            AppSpacing.xs,
          ),
          child: Row(
            children: [
              for (var index = 0; index < items.length; index++)
                Expanded(
                  child: _CBottomBarDestination(
                    item: items[index],
                    selected: index == currentIndex,
                    onTap: () => onTap(index),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CBottomBarDestination extends StatelessWidget {
  const _CBottomBarDestination({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final CBottomBarItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? CColors.primaryColor
        : CColors.primaryColor.withValues(alpha: 0.45);

    return Semantics(
      button: true,
      selected: selected,
      label: item.label,
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(AppRadius.l),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xs,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: selected
                  ? CColors.primaryColor.withValues(alpha: 0.12)
                  : Colors.transparent,
              borderRadius: const BorderRadius.all(AppRadius.l),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  selected ? (item.selectedIcon ?? item.icon) : item.icon,
                  color: color,
                  size: 22,
                ),
                const SizedBox(height: 2),
                Text(
                  item.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.2,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
