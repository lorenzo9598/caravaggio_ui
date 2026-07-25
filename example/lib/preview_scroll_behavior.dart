import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Whether this binary was built for the website live demo (`--dart-define=preview=true`).
bool get isPreviewMode {
  const fromBool = bool.fromEnvironment('preview', defaultValue: false);
  const fromString = String.fromEnvironment('preview', defaultValue: '');
  if (fromBool) return true;
  final normalized = fromString.toLowerCase();
  if (normalized == 'true') return true;
  if (fromString.isNotEmpty && normalized != 'false') return true;
  return false;
}

/// Live-demo scroll: click-and-drag like a finger; wheel / trackpad scroll disabled.
class PreviewScrollBehavior extends MaterialScrollBehavior {
  const PreviewScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => const {
        PointerDeviceKind.touch,
        PointerDeviceKind.stylus,
        PointerDeviceKind.invertedStylus,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.mouse,
        PointerDeviceKind.unknown,
      };
}

/// Absorbs wheel / trackpad [PointerScrollEvent]s so only drag scrolls.
///
/// Placed above app content with [HitTestBehavior.translucent] so it wins the
/// pointer-signal resolver (first registration) without blocking taps or drags.
class AbsorbWheelScroll extends StatelessWidget {
  const AbsorbWheelScroll({super.key, required this.child});

  final Widget child;

  static void _onPointerSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      GestureBinding.instance.pointerSignalResolver.register(event, _ignore);
    }
  }

  static void _ignore(PointerSignalEvent event) {}

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        child,
        const Positioned.fill(
          child: Listener(
            behavior: HitTestBehavior.translucent,
            onPointerSignal: _onPointerSignal,
            child: SizedBox.expand(),
          ),
        ),
      ],
    );
  }
}
