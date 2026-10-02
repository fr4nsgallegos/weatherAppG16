import 'package:flutter/material.dart';

class WeatherItem extends StatelessWidget {
  const WeatherItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset("assets/icons/nube.png", height: 50),
        Text("18 km/h", style: TextStyle(color: Colors.white, fontSize: 18)),
      ],
    );
  }
}
