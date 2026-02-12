import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:flutter/material.dart';

import 'page_constants.dart';

class ColorsPage extends StatelessWidget {
  const ColorsPage({super.key});

  static const double _gradientHeight = 88.0;
  static const double _cardPadding = 16.0;
  static const double _sectionSpacing = 24.0;

  Widget _gradientSwatch(LinearGradient gradient, {String? label}) {
    return Expanded(
      child: Container(
        height: _gradientHeight,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.all(AppRadius.m),
          boxShadow: AppShadow.sm,
        ),
        child: label != null
            ? Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CText.label(
                    label,
                    size: TextSize.small,
                    style: const TextStyle(
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black45,
                          offset: Offset(0, 1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : null,
      ),
    );
  }

  Widget _gradientRow(
    List<(LinearGradient gradient, String label)> items, {
    double gap = 8,
  }) {
    return Row(
      children: [
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0) SizedBox(width: gap),
          _gradientSwatch(items[i].$1, label: items[i].$2),
        ],
      ],
    );
  }

  Widget _buildPalette(
    BuildContext context, {
    required String title,
    required Color primary,
    required Color secondary,
    required Color onPrimary,
    required Color onSecondary,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(_cardPadding),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.all(AppRadius.l),
          boxShadow: AppShadow.sm,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CText.title(title, size: TextSize.medium),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 72,
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.all(AppRadius.s),
                    ),
                    alignment: Alignment.center,
                    child: CText.label(
                      'Primary',
                      size: TextSize.small,
                      style: TextStyle(color: onPrimary),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 72,
                    decoration: BoxDecoration(
                      color: secondary,
                      borderRadius: BorderRadius.all(AppRadius.s),
                    ),
                    alignment: Alignment.center,
                    child: CText.label(
                      'Secondary',
                      size: TextSize.small,
                      style: TextStyle(color: onSecondary),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: CText.title(text, size: TextSize.medium),
      ),
    );
  }

  Widget _gradientSection(
    String title,
    List<(LinearGradient gradient, String label)> items,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(title),
        _gradientRow(items),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Colors')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CText.headline('Palettes', size: TextSize.small),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildPalette(
                  context,
                  title: 'Default',
                  primary: CColors.primaryColor,
                  secondary: CColors.secondaryColor,
                  onPrimary: CColors.onPrimaryColor,
                  onSecondary: CColors.onSecondaryColor,
                ),
                const SizedBox(width: 12),
                _buildPalette(
                  context,
                  title: 'Light',
                  primary: CColors.primaryColorLight,
                  secondary: CColors.secondaryColorLight,
                  onPrimary: CColors.onPrimaryLightColor,
                  onSecondary: CColors.onSecondaryLightColor,
                ),
                const SizedBox(width: 12),
                _buildPalette(
                  context,
                  title: 'Dark',
                  primary: CColors.primaryColorDark,
                  secondary: CColors.secondaryColorDark,
                  onPrimary: CColors.onPrimaryDarkColor,
                  onSecondary: CColors.onSecondaryDarkColor,
                ),
              ],
            ),
            const SizedBox(height: _sectionSpacing),
            CText.headline('Gradients', size: TextSize.small),
            spacerSmall,
            _gradientSection(
              'Primary',
              [
                (CGradient.primaryLight, 'Light'),
                (CGradient.primaryDark, 'Dark'),
                (CGradient.primaryHighContrast, 'High contrast'),
              ],
            ),
            const SizedBox(height: 14),
            _gradientSection(
              'Secondary',
              [
                (CGradient.secondaryLight, 'Light'),
                (CGradient.secondaryDark, 'Dark'),
                (CGradient.secondaryHighContrast, 'High contrast'),
              ],
            ),
            const SizedBox(height: 14),
            _gradientSection(
              'Primary → Secondary',
              [
                (CGradient.primaryToSecondary, 'Default'),
                (CGradient.primaryLightToSecondaryLight, 'Light'),
                (CGradient.primaryDarkToSecondaryDark, 'Dark'),
              ],
            ),
            const SizedBox(height: 14),
            _gradientSection(
              'Variants',
              [
                (CGradient.primaryToSecondary.reverse, 'Reversed'),
                (CGradient.primaryToSecondary.opacity(0.5), '50% opacity'),
                (
                  CGradient.custom(
                    colors: CGradientColorType.primaryLightToSecondaryDark,
                    direction: CGradientDirection.centerLeftToTopRight,
                    opacity: 1,
                  ),
                  'Custom dir',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
