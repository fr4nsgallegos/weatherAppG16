import 'package:flutter/material.dart';
import 'package:weatherappg16/models/weather_model.dart';
import 'package:weatherappg16/services/api_weather_service.dart';
import 'package:weatherappg16/services/user_mockapi_service.dart';
import 'package:weatherappg16/widgets/search_widget.dart';
import 'package:weatherappg16/widgets/weather_item.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _cityController = TextEditingController();

  WeatherModel? weatherModel;
  ApiWeatherService apiWeatherService = ApiWeatherService();

  Future<void> getWeather() async {
    weatherModel = await apiWeatherService.getWeatherInfoByName(
      _cityController.text,
    );
    setState(() {});
  }

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
              function: () async {
                getWeather();
                _cityController.clear();
              },
            ),
            weatherModel == null
                ? Center(child: CircularProgressIndicator())
                : Container(
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
                          "${weatherModel!.location.name}, ${weatherModel!.location.country}",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Image.asset(
                          "assets/icons/heavycloudy.png",
                          height: 100,
                        ),
                        Text(
                          "${weatherModel!.current.tempC} °",
                          style: TextStyle(fontSize: 100, color: Colors.white),
                        ),
                        Divider(height: 48),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            WeatherItem(
                              value: weatherModel!.current.visKm,
                              unit: "km/h",
                              asset: "windspeed",
                            ),
                            WeatherItem(
                              value: weatherModel!.current.humidity.toDouble(),
                              unit: "%",
                              asset: "humidity",
                            ),
                            WeatherItem(
                              value: weatherModel!.current.cloud.toDouble(),
                              unit: "%",
                              asset: "cloud",
                            ),
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
