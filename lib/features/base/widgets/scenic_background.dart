import 'package:flutter/material.dart';

/// Tam ekran görsel + okunabilirlik için koyu gradient (büyük PNG’ler için).
class ScenicBackground extends StatelessWidget {
  const ScenicBackground({
    super.key,
    required this.assetPath,
    this.topOpacity = 0.5,
    this.bottomOpacity = 0.82,
  });

  final String assetPath;
  final double topOpacity;
  final double bottomOpacity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          assetPath,
          fit: BoxFit.cover,
          gaplessPlayback: true,
          errorBuilder: (_, __, ___) => const ColoredBox(color: Color(0xFF0A0E21)),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: topOpacity),
                Colors.black.withValues(alpha: bottomOpacity),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
