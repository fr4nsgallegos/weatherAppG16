import 'dart:convert';

import 'package:weatherappg16/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserMockapiService {
  final String baseUrl = "https://68cedf266dc3f35077803c79.mockapi.io/api/v1";

  // GET
  // Future getUsers() async {
  Future<List<UserModel>> getUsers() async {
    final response = await http.get(Uri.parse("$baseUrl/users"));
    // print("------------------------------");
    // print(response.statusCode);
    // print(response.body);
    // print(
    // esto devuelve "{" porque aún no lo interpreta como una lista de mapas, si no como un json (parecido a un string)
    //   response.body[1],
    // );
    // print("------------------------------");
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      // print(data);
      // print(data[0]); //esto si devuelve un mapa
      return data.map((user) => UserModel.fromJson(user)).toList();
    } else {
      throw Exception("Error al cargar los usuarios");
    }
  }

  // POST
  Future<UserModel> createUser(UserModel user) async {
    final reponse = await http.post(
      Uri.parse("$baseUrl/users/"),
      body: jsonEncode(user.toJson()),
      headers: {"Content-Type": "application/json"},
    );

    if (reponse.statusCode == 201) {
      print(reponse.body);
      return UserModel.fromJson(jsonDecode(reponse.body));
    } else {
      throw Exception(
        "Errore ${reponse.statusCode}  - ${reponse.body.toString()}",
      );
    }
  }

  // PUT
  Future<UserModel?> updateUser(UserModel user) async {
    final response = await http.put(
      Uri.parse("$baseUrl/users/${user.id}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user.toJson()),
    );
    print(response.statusCode);
    print(response.body);
    try {
      if (response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("error: $e");
    }
  }
}
