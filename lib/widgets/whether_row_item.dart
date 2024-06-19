import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather/constants.dart';

class WeatherRowItem extends StatelessWidget {
    final String icon;
    final String text;

  const WeatherRowItem({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.08,
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: CustomColors.cardBackgroundColor,
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              Image.asset(icon),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: 
                  Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: CustomColors.cardTextColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
