import 'package:flutter/material.dart';
import 'package:weatherappg16/services/api_weather_service.dart';
import 'package:weatherappg16/services/user_mockapi_service.dart';
import 'package:weatherappg16/widgets/search_widget.dart';
import 'package:weatherappg16/widgets/weather_item.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  TextEditingController _cityController = TextEditingController();

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
          ApiWeatherService apiWeatherService = ApiWeatherService();

          apiWeatherService.getWeatherInfo();
          // UserMockapiService userMockapiService = UserMockapiService();
          // userMockapiService.getUsers().then((valores) {
          //   print("*********************************");
          //   print(valores);
          //   print("*********************************");
          // });
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SearchWidget(
              controller: _cityController,
              function: () {
                ApiWeatherService apiWeatherService = ApiWeatherService();
                apiWeatherService.getWeatherInfoByName(_cityController.text);
              },
            ),
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
