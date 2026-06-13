import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:flutter/material.dart';

/// Wraps [child] and shows a loading overlay when [loading] is true.
///
/// The overlay blocks interaction and optionally dims the content with a scrim.
/// Use [loader] for a custom indicator; otherwise [CLoader.bouncing] is shown.
/// Pass [message] to display text below the loader.
class CWrapper extends StatelessWidget {
  const CWrapper({
    super.key,
    required this.child,
    required this.loading,
    this.loader,
    this.message,
    this.scrimColor,
    this.borderRadius,
  });

  /// Content shown beneath the loading overlay.
  final Widget child;

  /// When true, shows the loader overlay on top of [child].
  final bool loading;

  /// Custom loader widget. Defaults to [CLoader.bouncing].
  final Widget? loader;

  /// Optional text shown below the loader.
  final String? message;

  /// Scrim color over [child] while loading.
  ///
  /// Defaults to black at 35% opacity.
  final Color? scrimColor;

  /// Clips the loading scrim to these corners.
  ///
  /// When null, the overlay covers the full bounds of [child] with no clipping.
  /// Match this to the child's corner radius so the scrim follows rounded edges.
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (loading)
          Positioned.fill(
            child: borderRadius == null
                ? _buildOverlay()
                : ClipRRect(
                    borderRadius: borderRadius!,
                    child: _buildOverlay(),
                  ),
          ),
      ],
    );
  }

  Widget _buildOverlay() {
    return AbsorbPointer(
      child: ColoredBox(
        color: scrimColor ?? Colors.black.withValues(alpha: 0.35),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                loader ?? CLoader.bouncing(),
                if (message != null) ...[
                  const SizedBox(height: 16),
                  CText.body(
                    message!,
                    size: TextSize.medium,
                    textAlign: TextAlign.center,
                  ).primary,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
