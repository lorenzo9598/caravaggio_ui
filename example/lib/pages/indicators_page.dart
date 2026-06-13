import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui_app/pages/demo_pages.dart';
import 'package:caravaggio_ui_app/widgets/demo_scaffold_title.dart';
import 'package:caravaggio_ui_app/widgets/scaffold.dart';
import 'package:caravaggio_ui_app/widgets/section.dart';
import 'package:flutter/material.dart';

class IndicatorsPage extends StatelessWidget {
  const IndicatorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      demoPageId: DemoPageId.indicators,
      title: demoScaffoldTitleFor(DemoPageId.indicators),
      bodyBuilder: (context, topPadding) {
        return Sections(
          padding: EdgeInsets.only(top: topPadding + 12, left: 16, right: 16, bottom: 12),
          sections: [
            Section(
              title: 'Circular Indicators',
              icon: Icons.pie_chart_outline,
              items: [
                (
                  'Single Indicator',
                  CCircularIndicator.single(value: CircularValue(currentValue: 64, maxValue: 100), label: "Value 1"),
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
        );
      },
    );
  }
}
