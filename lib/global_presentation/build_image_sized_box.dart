import 'package:flutter/material.dart';

class ReusableFractionallySizedBox extends StatelessWidget {
  final double widthFactor;
  final String imagePath;
  final BoxFit fit;

  const ReusableFractionallySizedBox({super.key,
    required this.widthFactor,
    required this.imagePath,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: Image.asset(
        imagePath,
        fit: fit,
      ),
    );
  }
}
