import 'dart:math' as math;

import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:flutter/material.dart';

enum CLoaderType {
  bouncing,
  orbit,
  pulsing,
}

class CLoader extends StatelessWidget {
  const CLoader({
    super.key,
    required this.type,
    this.color,
    this.numberOfDots = 3,
  })  : assert(
          type != CLoaderType.bouncing || numberOfDots <= 5,
          'Bouncing loader supports at most 5 dots.',
        ),
        assert(
          type != CLoaderType.pulsing || numberOfDots <= 5,
          'Pulsing loader supports at most 5 dots.',
        );

  /// Tipo di animazione del loader.
  final CLoaderType type;

  /// Colore dei pallini.
  ///
  /// Se `null`, viene usato `CColors.primaryColor`.
  final Color? color;

  /// Numero di pallini da mostrare.
  ///
  /// Di default 3.
  final int numberOfDots;

  /// Loader con animazione "bouncing" (pallini che rimbalzano).
  factory CLoader.bouncing({
    Key? key,
    Color? color,
    int numberOfDots = 3,
  }) {
    return CLoader(
      key: key,
      type: CLoaderType.bouncing,
      color: color,
      numberOfDots: numberOfDots,
    );
  }

  /// Loader con animazione "orbit" (pallini che orbitano su un cerchio).
  factory CLoader.orbit({
    Key? key,
    Color? color,
    int numberOfDots = 3,
  }) {
    return CLoader(
      key: key,
      type: CLoaderType.orbit,
      color: color,
      numberOfDots: numberOfDots,
    );
  }

  /// Loader con animazione "pulsing" (pallini che pulsano).
  factory CLoader.pulsing({
    Key? key,
    Color? color,
    int numberOfDots = 3,
  }) {
    return CLoader(
      key: key,
      type: CLoaderType.pulsing,
      color: color,
      numberOfDots: numberOfDots,
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? CColors.primaryColor;

    switch (type) {
      case CLoaderType.bouncing:
        return _BouncingDotsLoaderInner(
          color: effectiveColor,
          numberOfDots: numberOfDots,
        );
      case CLoaderType.orbit:
        return _OrbitDotsLoaderInner(
          color: effectiveColor,
          numberOfDots: numberOfDots,
        );
      case CLoaderType.pulsing:
        return _PulsingDotsLoaderInner(
          color: effectiveColor,
          numberOfDots: numberOfDots,
        );
    }
  }
}

class _BouncingDotsLoaderInner extends StatefulWidget {
  const _BouncingDotsLoaderInner({
    required this.color,
    required this.numberOfDots,
  });

  final Color color;
  final int numberOfDots;

  @override
  State<_BouncingDotsLoaderInner> createState() => _BouncingDotsLoaderInnerState();
}

class _BouncingDotsLoaderInnerState extends State<_BouncingDotsLoaderInner> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();

    _animations = List.generate(widget.numberOfDots, (index) {
      final rawStart = index * 0.15;
      final rawEnd = rawStart + 0.5;

      // Manteniamo i valori nel range [0, 1] richiesto da Interval.
      final start = rawStart.clamp(0.0, 1.0);
      final end = rawEnd.clamp(start, 1.0);

      return TweenSequence<double>([
        TweenSequenceItem(tween: Tween(begin: 0, end: -8), weight: 50),
        TweenSequenceItem(tween: Tween(begin: -8, end: 0), weight: 50),
      ]).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: Curves.easeInOut),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildDot() {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: widget.color,
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.numberOfDots, (index) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            return Transform.translate(
              offset: Offset(0, _animations[index].value),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _buildDot(),
              ),
            );
          },
        );
      }),
    );
  }
}

class _OrbitDotsLoaderInner extends StatefulWidget {
  const _OrbitDotsLoaderInner({
    required this.color,
    required this.numberOfDots,
  });

  final Color color;
  final int numberOfDots;

  @override
  State<_OrbitDotsLoaderInner> createState() => _OrbitDotsLoaderInnerState();
}

class _OrbitDotsLoaderInnerState extends State<_OrbitDotsLoaderInner> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  static const double _radius = 14.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildDot() {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: widget.color,
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 2 * _radius + 12,
      height: 2 * _radius + 12,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          final angle = _controller.value * 2 * math.pi;
          return Stack(
            alignment: Alignment.center,
            children: List.generate(widget.numberOfDots, (index) {
              final offsetAngle = angle + (index * 2 * math.pi / widget.numberOfDots);
              final dx = _radius * math.cos(offsetAngle);
              final dy = _radius * math.sin(offsetAngle);
              return Transform.translate(
                offset: Offset(dx, dy),
                child: _buildDot(),
              );
            }),
          );
        },
      ),
    );
  }
}

class _PulsingDotsLoaderInner extends StatefulWidget {
  const _PulsingDotsLoaderInner({
    required this.color,
    required this.numberOfDots,
  });

  final Color color;
  final int numberOfDots;

  @override
  State<_PulsingDotsLoaderInner> createState() => _PulsingDotsLoaderInnerState();
}

class _PulsingDotsLoaderInnerState extends State<_PulsingDotsLoaderInner> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Animation<double>> _scaleAnimations;
  late final List<Animation<double>> _opacityAnimations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    _scaleAnimations = List.generate(widget.numberOfDots, (index) {
      // Distribuisce l'intervallo in base al numero di pallini.
      final segment = 1.0 / widget.numberOfDots;
      final rawStart = index * segment;
      // Ogni pallino occupa il 60% del proprio segmento, lasciando un po' di spazio "vuoto".
      final rawEnd = rawStart + segment * 0.6;

      final start = rawStart.clamp(0.0, 1.0);
      final end = rawEnd.clamp(start, 1.0);

      return Tween(begin: 0.7, end: 1.2).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: Curves.easeInOut),
        ),
      );
    });

    _opacityAnimations = List.generate(widget.numberOfDots, (index) {
      // Stessa logica di distribuzione usata per la scala.
      final segment = 1.0 / widget.numberOfDots;
      final rawStart = index * segment;
      final rawEnd = rawStart + segment * 0.6;

      final start = rawStart.clamp(0.0, 1.0);
      final end = rawEnd.clamp(start, 1.0);

      return Tween(begin: 0.3, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: Curves.easeInOut),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildDot(int index) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Opacity(
          opacity: _opacityAnimations[index].value,
          child: Transform.scale(
            scale: _scaleAnimations[index].value,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: widget.color,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.numberOfDots, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: _buildDot(index),
        );
      }),
    );
  }
}
