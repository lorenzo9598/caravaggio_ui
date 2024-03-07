// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:caravaggio_ui/caravaggio.dart';
import 'package:flutter/material.dart';

/// Extension for creating primary and secondary LinearProgressIndicator widgets.
extension CLinearProgressIndicator on LinearProgressIndicator {
  /// Creates a primary LinearProgressIndicator widget.
  static LinearProgressIndicator primary({Key? key}) {
    return LinearProgressIndicator(key: key, color: CaravaggioUI.instance.primaryColor);
  }

  /// Creates a secondary LinearProgressIndicator widget.
  static LinearProgressIndicator secondary({Key? key}) {
    return LinearProgressIndicator(key: key, color: CaravaggioUI.instance.secondaryColor);
  }
}

/// Extension for creating primary and secondary CircularProgressIndicator widgets.
extension CCircularProgressIndicator on CircularProgressIndicator {
  /// Creates a primary CircularProgressIndicator widget.
  static CircularProgressIndicator primary({Key? key}) {
    return CircularProgressIndicator(key: key, color: CaravaggioUI.instance.primaryColor);
  }

  /// Creates a secondary CircularProgressIndicator widget.
  static CircularProgressIndicator secondary({Key? key}) {
    return CircularProgressIndicator(key: key, color: CaravaggioUI.instance.secondaryColor);
  }
}
