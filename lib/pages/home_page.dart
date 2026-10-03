import 'package:flutter/material.dart';
import 'package:weatherappg16/services/user_mockapi_service.dart';
import 'package:weatherappg16/widgets/weather_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather app"),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Color(0xff2C2F31),
      ),
      backgroundColor: Color(0xff2C2F31),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          UserMockapiService userMockapiService = UserMockapiService();
          userMockapiService.getUsers().then((valores) {
            print("*********************************");
            print(valores);
            print("*********************************");
          });
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  colors: [Color(0xff2E5FEC), Color(0xff6796F7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.2, 0.8],
                ),
              ),

              child: Column(
                children: [
                  Text(
                    "Lima, Perú",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Image.asset("assets/icons/heavycloudy.png", height: 100),
                  Text(
                    "23.9 °",
                    style: TextStyle(fontSize: 100, color: Colors.white),
                  ),
                  Divider(height: 48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      WeatherItem(asset: "windspeed"),
                      WeatherItem(asset: "humidity"),
                      WeatherItem(asset: "cloud"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
