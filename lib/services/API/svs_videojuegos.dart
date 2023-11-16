// import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:app_see_game/class/SharedPreferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class SvcVideojuegos {
  static Future<Map<String, String>> getVideojuegos() async {
    String sToken = await SharedPreferencesClass.readData('token', "String");
    print(sToken);
    Map<String, String> mRespuesta = {"sCodigo": "0", "sMensaje": ""};
    var url = Uri.http(
        "${dotenv.env['HOST']!}:${dotenv.env['PORT']!}", '/api/videogames');

    print(url);
    try {
      var response = await http.get(url, headers: {
        "Authorization": sToken     
      });
      print(response.body);
      List<dynamic> data = json.decode(response.body);
      print(data);

      if (data.isNotEmpty) {
        // Aquí asumimos que la lista tiene al menos un elemento
        var firstItem = data[0];
        if (firstItem['error'] != null) {
          mRespuesta['sCodigo'] = "0";
          mRespuesta['sMensaje'] = firstItem['error'].toString();
        } else {
          mRespuesta['sCodigo'] = "1";
          mRespuesta['sMensaje'] = firstItem['message'].toString();
        }
      }
    } catch (e) {
      print('Error making HTTP request: ${e}');
      mRespuesta['sMensaje'] = "A ocurrido un error";
    }

    return Future.value(Future.sync(() => mRespuesta));
  }
}
