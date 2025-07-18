import 'package:flutter/material.dart';
import 'package:weather/theme/theme_config.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    
    return Container(
      decoration: BoxDecoration(
        gradient: brightness == Brightness.dark
        ? AppGradients.darkGradient
        : AppGradients.lightGradient,
      ),
    );
  }
}
