import 'package:flutter/material.dart';

/// A utility class that provides commonly used [Radius] values for consistent UI design.
class AppRadius {
  // Private constructor to prevent instantiation.
  AppRadius._();

  /// Radius of 0.
  static const none = Radius.zero;

  /// Extra extra small radius of 2.
  static const xxs = Radius.circular(2);

  /// Extra small radius of 4.
  static const xs = Radius.circular(4);

  /// Small radius of 6.
  static const s = Radius.circular(6);

  /// Medium radius of 15.
  static const m = Radius.circular(15);

  /// Large radius of 20.
  static const l = Radius.circular(20);

  /// Extra large radius of 25.
  static const xl = Radius.circular(25);

  /// Extra extra large radius of 30.
  static const xxl = Radius.circular(30);

  /// Returns a [Radius] with the given [radius] value.
  static Radius custom(double radius) {
    return Radius.circular(radius);
  }
}
