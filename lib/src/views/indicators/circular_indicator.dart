import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

/// Constant representing the default line width for circular progress indicators.
const double _kLineWidth = 8.0;

/// Constant representing the default space between circular progress indicators.
const double _kSpace = 1.0;

/// Constant representing the default radius for circular progress indicators.
const double _kRadius = 77 / 2;

/// A class representing a value for a circular indicator, including the current and maximum values.
class CircularValue {
  /// The maximum value of the indicator.
  final double maxValue;

  /// The current value of the indicator.
  final double currentValue;

  /// Constructs a [CircularValue] with the given [maxValue] and [currentValue].
  CircularValue({
    required this.maxValue,
    required this.currentValue,
  });

  /// Returns the percentage (between 0 and 1) of the current value relative to the maximum value.
  double get percent => currentValue / maxValue;
}

/// A widget that displays circular progress indicators along with labels.
class CCircularIndicator extends StatelessWidget {
  /// Flag indicating whether the widget should be dense or not.
  final bool isDense;

  /// The value for the external (outer) circular indicator.
  final CircularValue externalValue;

  /// The value for the internal (inner) circular indicator, if present.
  final CircularValue? internalValue;

  /// The list of label indicators to display next to the circular indicator.
  final List<CLabelIndicator> labels;

  /// The widget to display at the center of the circular indicator.
  final Widget? center;

  /// Constructs a CCircularIndicator widget.
  const CCircularIndicator._({
    required this.externalValue,
    this.internalValue,
    required this.labels,
    this.isDense = false,
    this.center,
  });

  /// Constructs a CCircularIndicator widget with a single progress indicator.
  factory CCircularIndicator.single({
    required CircularValue value,
    String? label,
    bool isDense = false,
    Widget? center,
  }) {
    final List<CLabelIndicator> labels = [];
    if (label != null) {
      labels.add(
        CLabelIndicator(
          label: label,
          color: CColors.primaryColor,
          value: value.currentValue,
          fontSize: isDense ? 12 : 14,
        ),
      );
    }

    return CCircularIndicator._(
      externalValue: value,
      labels: labels,
      isDense: isDense,
      center: center,
    );
  }

  /// Constructs a CCircularIndicator widget with two progress indicators.
  factory CCircularIndicator.double({
    required CircularValue externalValue,
    required CircularValue internalValue,
    String? externalLabel,
    String? internalLabel,
    bool isDense = false,
    Widget? center,
  }) {
    final List<CLabelIndicator> labels = [];
    if (externalLabel != null) {
      labels.add(
        CLabelIndicator(
          label: externalLabel,
          color: CColors.primaryColor,
          value: externalValue.currentValue,
          fontSize: isDense ? 12 : 14,
        ),
      );
    }
    if (internalLabel != null) {
      labels.add(
        CLabelIndicator(
          label: internalLabel,
          color: CColors.secondaryColor,
          value: internalValue.currentValue,
          fontSize: isDense ? 12 : 14,
        ),
      );
    }

    return CCircularIndicator._(
      externalValue: externalValue,
      internalValue: internalValue,
      labels: labels,
      isDense: isDense,
      center: center,
    );
  }

  factory CCircularIndicator.percent({
    required CircularValue value,
    String? maxLabel,
    String? currentLabel,
    bool isDense = false,
    Widget? center,
  }) {
    final List<CLabelIndicator> labels = [];
    if (currentLabel != null) {
      labels.add(
        CLabelIndicator(
          label: currentLabel,
          color: CColors.primaryColor,
          value: value.currentValue,
          fontSize: isDense ? 12 : 14,
        ),
      );
      if (maxLabel != null) {
        labels.add(
          CLabelIndicator(
            label: maxLabel,
            color: CColors.secondaryColor,
            value: value.maxValue,
            fontSize: isDense ? 12 : 14,
          ),
        );
      }
    }

    final Widget centerWidget = center ??
        CText.label(
          '${(value.percent * 100).toStringAsFixed(1)}%',
        ).bold;

    return CCircularIndicator._(
      externalValue: value,
      labels: labels,
      isDense: isDense,
      center: centerWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool hasLabels = labels.isNotEmpty;
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
                radius: _kRadius,
                percent: externalValue.percent,
                gradient: CGradient.primaryDarkToSecondaryDark,
                lineWidth: _kLineWidth,
                center: center,
              ),
            ),
            if (internalValue != null)
              Center(
                child: _CProgressIndicator(
                  radius: _kRadius - _kLineWidth - _kSpace,
                  percent: internalValue!.percent,
                  gradient: CGradient.primaryLightToSecondaryLight,
                  lineWidth: _kLineWidth,
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
              for (var i = 0; i < labels.length; i++) ...[
                labels[i],
                if (i < labels.length - 1) const SizedBox(height: 8),
              ],
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

  /// Widget to display at the center of the circular progress indicator.
  final Widget? center;

  /// Constructs a _CProgressIndicator widget.
  const _CProgressIndicator({
    required this.radius,
    required this.percent,
    this.gradient,
    required this.lineWidth,
    this.center,
  });

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
      center: center,
    );
  }
}

/// A private widget representing a label indicator.
class CLabelIndicator extends StatelessWidget {
  /// Text label for the indicator.
  final String label;

  /// Numeric value associated with the indicator.
  final double value;

  /// Color of the indicator.
  final Color color;

  /// Font size of the label.
  final double fontSize;

  /// Constructs a _CLabelIndicator widget.
  const CLabelIndicator({
    super.key,
    required this.label,
    required this.value,
    required this.color,
    required this.fontSize,
  });

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
            children: [TextSpan(text: '$label: '), TextSpan(text: '${value.round()}', style: const TextStyle(fontWeight: FontWeight.bold))],
          ),
        ),
      ],
    );
  }
}
