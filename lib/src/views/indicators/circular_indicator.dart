import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

/// Constant representing the default line width for circular progress indicators.
const double lineWidth = 8.0;

/// Constant representing the default space between circular progress indicators.
const double space = 1.0;

/// Constant representing the default radius for circular progress indicators.
const double radius = 77 / 2;

/// A widget that displays circular progress indicators along with labels.
class CCircularIndicator extends StatelessWidget {
  /// Maximum value for the external progress indicator.
  final double maxExternalValue;

  /// Current value for the external progress indicator.
  final double currentExternalValue;

  /// Flag indicating whether the widget should be dense or not.
  final bool isDense;

  /// Maximum value for the internal progress indicator.
  final double? maxInternalValue;

  /// Current value for the internal progress indicator.
  final double? currentInternalValue;

  /// Label for the internal progress indicator.
  final String? internalLabel;

  /// Label for the external progress indicator.
  final String? externalLabel;

  /// Constructs a CCircularIndicator widget.
  const CCircularIndicator._({
    Key? key,
    required this.maxExternalValue,
    required this.currentExternalValue,
    this.externalLabel,
    this.maxInternalValue,
    this.currentInternalValue,
    this.internalLabel,
    this.isDense = false,
  }) : super(key: key);

  /// Constructs a CCircularIndicator widget with a single progress indicator.
  factory CCircularIndicator.single({
    required double maxValue,
    required double currentValue,
    String? label,
    bool isDense = false,
  }) {
    return CCircularIndicator._(
      maxExternalValue: maxValue,
      currentExternalValue: currentValue,
      externalLabel: label,
      isDense: isDense,
    );
  }

  /// Constructs a CCircularIndicator widget with two progress indicators.
  factory CCircularIndicator.double({
    required double maxExternalValue,
    required double currentExternalValue,
    required double maxInternalValue,
    required double currentInternalValue,
    String? externalLabel,
    String? internalLabel,
    bool isDense = false,
  }) {
    return CCircularIndicator._(
      maxExternalValue: maxExternalValue,
      currentExternalValue: currentExternalValue,
      maxInternalValue: maxInternalValue,
      currentInternalValue: currentInternalValue,
      externalLabel: externalLabel,
      internalLabel: internalLabel,
      isDense: isDense,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool hasLabels = internalLabel != null || externalLabel != null;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: _CProgressIndicator(
                radius: radius,
                percent: currentExternalValue / maxExternalValue,
                gradient: CGradient.primaryDarkToSecondaryDark,
                lineWidth: lineWidth,
              ),
            ),
            if (currentInternalValue != null && maxInternalValue != null)
              Center(
                child: _CProgressIndicator(
                  radius: radius - lineWidth - space,
                  percent: currentInternalValue! / maxInternalValue!,
                  gradient: CGradient.primaryLightToSecondaryLight,
                  lineWidth: lineWidth,
                ),
              ),
          ],
        ),
        if (hasLabels) SizedBox(width: isDense ? 8 : 20),
        if (hasLabels)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (internalLabel != null && currentInternalValue != null)
                _CLabelIndicator(
                    label: internalLabel!,
                    fontSize: isDense ? 12 : 14,
                    value: currentInternalValue!,
                    color: CaravaggioUI.instance.secondaryColor),
              const SizedBox(height: 8),
              if (externalLabel != null)
                _CLabelIndicator(
                    label: externalLabel!,
                    fontSize: isDense ? 12 : 14,
                    value: currentExternalValue,
                    color: CaravaggioUI.instance.primaryColor),
            ],
          ),
      ],
    );
  }
}

/// A private widget representing a single circular progress indicator.
class _CProgressIndicator extends StatelessWidget {
  /// Radius of the circular progress indicator.
  final double radius;

  /// Percentage value of the progress indicator.
  final double percent;

  /// Gradient to be applied to the progress indicator.
  final LinearGradient? gradient;

  /// Width of the progress indicator line.
  final double lineWidth;

  /// Constructs a _CProgressIndicator widget.
  const _CProgressIndicator({
    Key? key,
    required this.radius,
    required this.percent,
    this.gradient,
    required this.lineWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: radius,
      lineWidth: lineWidth,
      percent: percent,
      circularStrokeCap: CircularStrokeCap.round,
      startAngle: 180,
      fillColor: Colors.transparent,
      linearGradient: gradient,
    );
  }
}

/// A private widget representing a label indicator.
class _CLabelIndicator extends StatelessWidget {
  /// Text label for the indicator.
  final String label;

  /// Numeric value associated with the indicator.
  final double value;

  /// Color of the indicator.
  final Color color;

  /// Font size of the label.
  final double fontSize;

  /// Constructs a _CLabelIndicator widget.
  const _CLabelIndicator({
    Key? key,
    required this.label,
    required this.value,
    required this.color,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(3)),
          ),
        ),
        const SizedBox(width: 8),
        RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.black, fontSize: fontSize),
            children: [
              TextSpan(text: "$label: "),
              TextSpan(
                  text: "${value.round()}",
                  style: const TextStyle(fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ],
    );
  }
}
