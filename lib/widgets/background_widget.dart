import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: brightness == Brightness.dark
              ? const [
                  Color(0xFF1A1F38), // Тёмно-синий
                  Color(0xFF0D1321), // Очень тёмно-синий
                  Color(0xFF000000), // Чёрный
                ]
              : const [
                  Color(0xFF7CB9E8), // Темно-голубой
                  Color(0xFF4F97D5), // Более темный голубой
                  Color(0xFF2E5894), // Темно-синий
                ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
    );
  }
}
