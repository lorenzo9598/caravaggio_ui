import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui_app/widgets/demo_scaffold_title.dart';
import 'package:caravaggio_ui_app/widgets/scaffold.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  static const _kpiData = [
    ('Revenue', '\$24.8k', '+12%'),
    ('Users', '1,842', '+8%'),
    ('Orders', '326', '+5%'),
  ];

  static const _tableHeaders = ['Metric', 'This week', 'Trend'];
  static const _tableRows = [
    ['Page views', '12,480', '+4.2%'],
    ['Sign-ups', '284', '+11%'],
    ['Conversion', '3.8%', '+0.6%'],
    ['Bounce rate', '41%', '-2.1%'],
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final tableHeader = CTableHeader(
      titles: _tableHeaders.map((title) => CTableCell(text: title)).toList(),
    );
    final tableRows = _tableRows
        .map(
          (row) => CTableRow(
            values: row.map((cell) => CTableCell(text: cell)).toList(),
          ),
        )
        .toList();

    return CustomScaffold(
      showAppDrawer: false,
      backToHome: true,
      title: demoScaffoldTitle('Statistics'),
      bodyBuilder: (context, topPadding) {
        return ListView(
          padding: EdgeInsets.fromLTRB(16, topPadding + 16, 16, 24),
          children: [
            CText.label('Overview', size: TextSize.small),
            const SizedBox(height: 10),
            LayoutBuilder(
              builder: (context, constraints) {
                final cardWidth = (constraints.maxWidth - 16) / 3;
                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _kpiData
                      .map(
                        (kpi) => SizedBox(
                          width: cardWidth.clamp(96, constraints.maxWidth),
                          child: _StatCard(
                            label: kpi.$1,
                            value: kpi.$2,
                            delta: kpi.$3,
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: const BorderRadius.all(AppRadius.l),
                boxShadow: AppShadow.sm,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CText.title('Monthly goal', size: TextSize.small),
                  const SizedBox(height: 16),
                  Center(
                    child: CCircularIndicator.percent(
                      value: CircularValue(currentValue: 72, maxValue: 100),
                      currentLabel: 'Achieved',
                      maxLabel: 'Target',
                      isDense: false,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            CText.title('Weekly breakdown', size: TextSize.small),
            const SizedBox(height: 12),
            CTable(header: tableHeader, rows: tableRows),
          ],
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.delta,
  });

  final String label;
  final String value;
  final String delta;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPositive = delta.startsWith('+');

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.all(AppRadius.m),
        boxShadow: AppShadow.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CText.label(label, size: TextSize.small),
          const SizedBox(height: 6),
          CText.headline(value, size: TextSize.small),
          const SizedBox(height: 4),
          CText.body(
            delta,
            size: TextSize.small,
            style: TextStyle(
              color: isPositive ? CColors.primaryColor : CColors.secondaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
