import 'package:http/http.dart' as http;

class ApiWeatherService {
  String urlBase = "http://api.weatherapi.com/v1/";

  Future<void> getWeatherInfo() async {
    final url = Uri.parse(
      "$urlBase/current.json?key=70866d7ade244a3c9ca20142230509&q=London&aqi=no",
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print("""Weather api response
        response: $response
        statuscode: ${response.statusCode}
        body: ${response.body}""");
      }
    } catch (e) {
      throw Exception("Error inesperado: $e");
    }
  }

  Future<void> getWeatherInfoByName(String ciudad) async {
    final url = Uri.parse(
      "$urlBase/current.json?key=70866d7ade244a3c9ca20142230509&q=$ciudad&aqi=no",
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print("""Weather api response
        response: $response
        statuscode: ${response.statusCode}
        body: ${response.body}""");
      }
    } catch (e) {
      throw Exception("Error inesperado: $e");
    }
  }
}
