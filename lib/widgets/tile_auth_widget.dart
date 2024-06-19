import 'package:flutter/material.dart';

class TileAuth extends StatelessWidget {
  const TileAuth({super.key, required this.icon, required this.onTapTile});
  final String icon;
  final Function() onTapTile;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTapTile,
      child: Container(
        width: 100,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(icon),
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
