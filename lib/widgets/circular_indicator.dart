import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CircularIndicator extends StatelessWidget {
  final double value;
  final double size;
  final String title;

  const CircularIndicator(
      {super.key,
      required this.value,
      required this.size,
      required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: size,
      height: size,
      child: FittedBox(
        fit: BoxFit.contain,
        child: CircularPercentIndicator(
          animation: true,
          animationDuration: 2500,
          radius: size / 2,
          lineWidth: size / 10,
          percent: value,
          backgroundColor: theme.colorScheme.primary,
          progressColor: theme.colorScheme.secondary,
          circularStrokeCap: CircularStrokeCap.butt,
          center: Text(title),
        ),
      ),
    );
  }
}
