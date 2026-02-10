import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:flutter/material.dart';

class IndicatorsPage extends StatelessWidget {
  const IndicatorsPage({super.key});

  static const double _cardPadding = 16.0;
  static const double _itemSpacing = 16.0;

  Widget _buildIndicatorCard(
    BuildContext context, {
    required String label,
    required Widget indicator,
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
          Center(child: indicator),
        ],
      ),
    );
  }

  Widget _buildIndicatorSection(
    BuildContext context,
    String title,
    List<(String label, Widget indicator)> items,
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
              child: _buildIndicatorCard(context, label: item.$1, indicator: item.$2),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Indicators')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildIndicatorSection(
              context,
              'Circular Indicators',
              [
                (
                  'Single Indicator',
                  CCircularIndicator.single(
                    value: CircularValue(currentValue: 64, maxValue: 100),
                    label: "Value 1",
                  ),
                ),
                (
                  'Double Indicator',
                  CCircularIndicator.double(
                    externalValue: CircularValue(currentValue: 64, maxValue: 100),
                    internalValue: CircularValue(currentValue: 87, maxValue: 100),
                    internalLabel: "Value 1",
                    externalLabel: "Value 2",
                  ),
                ),
                (
                  'Percent Indicator (Dense)',
                  CCircularIndicator.percent(
                    value: CircularValue(currentValue: 64, maxValue: 100),
                    currentLabel: "Current",
                    maxLabel: "Max",
                    isDense: true,
                  ),
                ),
                (
                  'Percent Indicator (Normal)',
                  CCircularIndicator.percent(
                    value: CircularValue(currentValue: 64, maxValue: 100),
                    currentLabel: "Current",
                    maxLabel: "Max",
                    isDense: false,
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
