// import 'package:http/http.dart' as http;

import 'package:app_see_game/class/SharedPreferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SvcVideojuegos {
  static Future<Map<String, String>> getVideojuegos() async {
    Map<String, String> mRespuesta = {"sCodigo": "0", "sMensaje": ""};
    var url = Uri.http(
        "${dotenv.env['HOST']!}:${dotenv.env['PORT']!}", '/api/videogames');

    print(url);
    try {
      var response = await http.get(url, headers: {
        "authorization":
            await SharedPreferencesClass.readData('token', "String")
      });
      // print(response.body);
      // Map<String, dynamic> data = json.decode(response.body);
      // print(data);
      // if (data['error'] != null) {
      //   mRespuesta['sCodigo'] = "0";
      //   mRespuesta['sMensaje'] = data['error'].toString();
      // } else {
      //   mRespuesta['sCodigo'] = "1";
      //   mRespuesta['sMensaje'] = data['message'].toString();
      // }
    } catch (e) {
      print('Error making HTTP request: ${e}');
      mRespuesta['sMensaje'] = "A ocurrido un error";
    }

    return Future.value(Future.sync(() => mRespuesta));
  }
}
