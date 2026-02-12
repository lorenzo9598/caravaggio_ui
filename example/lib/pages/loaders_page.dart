import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:flutter/material.dart';

class LoadersPage extends StatelessWidget {
  const LoadersPage({super.key});

  static const double _cardPadding = 16.0;
  static const double _sectionSpacing = 8.0;
  static const double _itemSpacing = 16.0;

  Widget _buildLoaderCard(
    BuildContext context, {
    required String label,
    required Widget loader,
  }) {
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
          const SizedBox(height: 16),
          Center(child: loader),
        ],
      ),
    );
  }

  Widget _buildLoaderSection(
    BuildContext context,
    String title,
    List<(String label, Widget loader)> items,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: CText.title(title, size: TextSize.medium),
        ),
        ...items.map((item) => Padding(
              padding: EdgeInsets.only(
                bottom: items.indexOf(item) < items.length - 1 ? _itemSpacing : 0,
              ),
              child: _buildLoaderCard(context, label: item.$1, loader: item.$2),
            )),
      ],
    );
  }

  Widget _buildLoaderExpansionSection(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: _sectionSpacing),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.all(AppRadius.l),
        boxShadow: AppShadow.sm,
      ),
      child: Theme(
        data: theme.copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(AppRadius.l),
          ),
          collapsedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(AppRadius.l),
          ),
          iconColor: CColors.primaryColor,
          collapsedIconColor: theme.iconTheme.color,
          title: CText.headline(title, size: TextSize.small),
          children: children,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loaders')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildLoaderExpansionSection(
              context,
              'CLoader',
              [
                _buildLoaderSection(
                  context,
                  'Factory',
                  [
                    (
                      'Bouncing',
                      CLoader.bouncing(),
                    ),
                    (
                      'Orbit',
                      CLoader.orbit(),
                    ),
                    (
                      'Pulsing',
                      CLoader.pulsing(),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildLoaderSection(
                  context,
                  'Customizzazioni',
                  [
                    (
                      'Bouncing - Primary (3 pallini)',
                      CLoader.bouncing(
                        color: CColors.primaryColor,
                        numberOfDots: 3,
                      ),
                    ),
                    (
                      'Bouncing - Secondary (5 pallini)',
                      CLoader.bouncing(
                        color: CColors.secondaryColor,
                        numberOfDots: 5,
                      ),
                    ),
                    (
                      'Orbit - Primary Light (4 pallini)',
                      CLoader.orbit(
                        color: CColors.primaryColorLight,
                        numberOfDots: 4,
                      ),
                    ),
                    (
                      'Orbit - Secondary Dark (6 pallini)',
                      CLoader.orbit(
                        color: CColors.secondaryColorDark,
                        numberOfDots: 6,
                      ),
                    ),
                    (
                      'Pulsing - Primary Dark (2 pallini)',
                      CLoader.pulsing(
                        color: CColors.primaryColorDark,
                        numberOfDots: 2,
                      ),
                    ),
                    (
                      'Pulsing - On Secondary (4 pallini)',
                      CLoader.pulsing(
                        color: CColors.secondary,
                        numberOfDots: 5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: _sectionSpacing),
            _buildLoaderExpansionSection(
              context,
              'CCircularProgressIndicator',
              [
                _buildLoaderCard(
                  context,
                  label: 'Circular Progress (Primary)',
                  loader: CCircularProgressIndicator.primary(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: _itemSpacing),
                  child: _buildLoaderCard(
                    context,
                    label: 'Circular Progress (Secondary)',
                    loader: CCircularProgressIndicator.secondary(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: _sectionSpacing),
            _buildLoaderExpansionSection(
              context,
              'CLinearProgressIndicator',
              [
                _buildLoaderCard(
                  context,
                  label: 'Linear Progress (Primary)',
                  loader: SizedBox(
                    width: double.infinity,
                    child: CLinearProgressIndicator.primary(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: _itemSpacing),
                  child: _buildLoaderCard(
                    context,
                    label: 'Linear Progress (Secondary)',
                    loader: SizedBox(
                      width: double.infinity,
                      child: CLinearProgressIndicator.secondary(),
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
}
