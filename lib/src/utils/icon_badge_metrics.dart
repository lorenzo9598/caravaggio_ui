import 'package:caravaggio_ui/src/utils/app_radius.dart';
import 'package:flutter/material.dart';

/// Shared layout metrics for [CIconBadge] and [CButton.icon].
abstract final class CIconBadgeMetrics {
  static const double iconSize = 20;
  static const EdgeInsets padding = EdgeInsets.all(8);
  static const double borderWidth = 1;

  static final BorderRadius borderRadius = BorderRadius.all(AppRadius.custom(10));
}
