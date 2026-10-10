import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/web.dart';
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
  Logger logger = Logger();

  Future<void> getWeather() async {
    weatherModel = await apiWeatherService.getWeatherInfoByName(
      _cityController.text,
    );
    setState(() {});
  }

  Future<void> getWeatherByPosition() async {
    Position? _pos = await getPosition();
    if (_pos == null) {
      print("No se pudo obtener la posición");
      return null;
    }

    weatherModel = await apiWeatherService.getWeatherInfoByPosition(_pos);
    setState(() {});
  }

  Future<Position?> getPosition() async {
    bool serviceEnabled;
    LocationPermission locationPermission;

    // verificamos si el servicio esta habilitado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      print("Los servicios estan inhabilitados");
      return null;
    }

    // Verificar los permisos
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        print("Permiso de ubicación denegado");
        return null;
      }
    }

    if (locationPermission == LocationPermission.deniedForever) {
      print("Los permisos de ubicación estan permanetemente denegados");
      return null;
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      logger.d(position);
      return position;
    } catch (e) {
      print("Error al obtener la ubicación: $e");
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    getWeatherByPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              getWeatherByPosition();
            },
            icon: Icon(Icons.location_on_outlined),
          ),
        ],
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
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        SizedBox(height: 16),
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
