import 'package:flutter/material.dart';

class ChartTitle extends StatelessWidget {
  final String text;
  const ChartTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Text(
            text,
            style: TextStyle(
              color: colors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          );
  }
}