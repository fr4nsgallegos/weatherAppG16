import 'package:flutter/material.dart';

class WeatherItem extends StatelessWidget {
  String asset;
  String unit;
  double value;
  WeatherItem({
    super.key,
    required this.unit,
    required this.value,
    required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset("assets/icons/$asset.png", height: 50),
        Text(
          "$value $unit",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ],
    );
  }
}
