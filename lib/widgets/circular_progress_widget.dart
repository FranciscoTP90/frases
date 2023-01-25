import 'package:flutter/material.dart';
import 'package:frases/theme/colors.dart';

class CircularProgressWidget extends StatelessWidget {
  const CircularProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: ColorsApp.red,
        strokeWidth: 6.0,
      ),
    );
  }
}
