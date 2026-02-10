import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:flutter/material.dart';

class LoadersPage extends StatelessWidget {
  const LoadersPage({super.key});

  static const double _cardPadding = 16.0;
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
          child: CText.headline(title, size: TextSize.medium),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loaders')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildLoaderSection(
              context,
              'Progress Indicators',
              [
                (
                  'Circular Progress (Primary)',
                  CCircularProgressIndicator.primary(),
                ),
                (
                  'Circular Progress (Secondary)',
                  CCircularProgressIndicator.secondary(),
                ),
                (
                  'Linear Progress (Primary)',
                  SizedBox(
                    width: double.infinity,
                    child: CLinearProgressIndicator.primary(),
                  ),
                ),
                (
                  'Linear Progress (Secondary)',
                  SizedBox(
                    width: double.infinity,
                    child: CLinearProgressIndicator.secondary(),
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
