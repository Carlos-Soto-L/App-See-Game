// import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:app_see_game/class/SharedPreferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class SvcVideojuegos {

  static Future<List<Map<String, dynamic>>> getVideojuegos() async {
    String sToken = await SharedPreferencesClass.readData('token', "String");
    List<Map<String, dynamic>> aRespuesta = [];
    var url = Uri.https(
        "${dotenv.env['HOST']!}:${dotenv.env['PORT']!}", '/api/videogames');

    print(url);
    try {
      var response = await http.get(url, headers: {
        "Authorization": sToken     
      });
      if (response.statusCode == 200) {
        // Parsea la respuesta JSON a una lista de dinámicos
        List<dynamic> data = json.decode(response.body);

        // Mapea la lista de dinámicos a una lista de mapas
        aRespuesta = data.map((item) => item as Map<String, dynamic>).toList();

        // Maneja errores específicos si es necesario
        var firstItem = data.isNotEmpty ? data[0] : null;
        if (firstItem != null && firstItem['error'] != null) {
          // Manejar el error
        } else {
          // Manejar el caso de éxito
        }
      } else {
        print('Error making HTTP request. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error making HTTP request: ${e}');
      // mRespuesta['sMensaje'] = "A ocurrido un error";
    }

    return Future.value(Future.sync(() => aRespuesta));
  }


    static Future<List<Map<String, dynamic>>> getVideojuegosSearch(String sNombre) async {
    String sToken = await SharedPreferencesClass.readData('token', "String");
    List<Map<String, dynamic>> aRespuesta = [];
    var url = Uri.https(
        "${dotenv.env['HOST']!}:${dotenv.env['PORT']!}", "/api/videogame/name/${sNombre.toString().trim()}");

    print(url);
    try {
      var response = await http.get(url, headers: {
        "Authorization": sToken     
      });
      if (response.statusCode == 200) {
        // Parsea la respuesta JSON a una lista de dinámicos
        List<dynamic> data = json.decode(response.body);

        // Mapea la lista de dinámicos a una lista de mapas
        aRespuesta = data.map((item) => item as Map<String, dynamic>).toList();

        // Maneja errores específicos si es necesario
        var firstItem = data.isNotEmpty ? data[0] : null;
        if (firstItem != null && firstItem['error'] != null) {
          // Manejar el error
        } else {
          // Manejar el caso de éxito
        }
      } else {
        print('Error making HTTP request. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error making HTTP request: ${e}');
      // mRespuesta['sMensaje'] = "A ocurrido un error";
    }

    return Future.value(Future.sync(() => aRespuesta));
  }


  static Future<List<Map<String, dynamic>>> getDetalleJuego(String sIDJuego) async {
    String sToken = await SharedPreferencesClass.readData('token', "String");
    List<Map<String, dynamic>> aRespuesta = [];
    var url = Uri.https(
        "${dotenv.env['HOST']!}:${dotenv.env['PORT']!}", "/api/videogame/${sIDJuego}");

    try {
      var response = await http.get(url, headers: {
        "Authorization": sToken     
      });
      if (response.statusCode == 200) {
        // Parsea la respuesta JSON a una lista de dinámicos
        List<dynamic> data = json.decode(response.body);

        // Mapea la lista de dinámicos a una lista de mapas
        aRespuesta = data.map((item) => item as Map<String, dynamic>).toList();

        // Maneja errores específicos si es necesario
        var firstItem = data.isNotEmpty ? data[0] : null;
        if (firstItem != null && firstItem['error'] != null) {
          // Manejar el error
        } else {
          // Manejar el caso de éxito
        }
      } else {
        print('Error making HTTP request. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error making HTTP request: ${e}');
      // mRespuesta['sMensaje'] = "A ocurrido un error";
    }

    return Future.value(Future.sync(() => aRespuesta));
  }


}
