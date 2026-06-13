import 'package:flutter/material.dart';

/// Top-left menu control that opens the app navigation drawer.
class DrawerMenuAction extends StatelessWidget {
  const DrawerMenuAction({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(2),
      child: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.menu),
      ),
    );
  }
}
