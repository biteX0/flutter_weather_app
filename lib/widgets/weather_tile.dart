import 'package:flutter/material.dart';
import 'package:weather/widgets/circular_indicator.dart';

class WeatherTile extends StatelessWidget {
  final String icon;
  final String prefix;
  final String suffix;
  final bool showIndicator;
  final double value;

  const WeatherTile({
    Key? key,
    required this.icon,
    required this.prefix,
    required this.suffix,
    required this.value,
    this.showIndicator = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  prefix,
                  style: theme.textTheme.bodyMedium,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(icon, width: 28, height: 28),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: showIndicator
                  ? CircularIndicator(
                      value: value / 100,
                      size: 60,
                      title: "${value.toInt()}$suffix",
                    )
                  : Text(
                      "${value.toStringAsFixed(1)}$suffix",
                      style: theme.textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
