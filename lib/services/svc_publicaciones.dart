// import 'package:http/http.dart' as http;

import 'package:app_see_game/class/SharedPreferences.dart';
import 'package:app_see_game/models/mdl_usuario.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SvcAutenticacion {


  static Future<Map<String, String>> getPublicaciones({String? sIdPublicacion}) async {
    Map<String, String> mRespuesta = {"sCodigo": "0", "sMensaje": ""};
    var url =
        Uri.http("${dotenv.env['HOST']!}:${dotenv.env['PORT']!}", '/users/verPublicacion');

    print(url);
    try {
      var response =
          await http.get(url,
           headers: {'authorization': SharedPreferencesClass.readData('token', "String").toString() });
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      Map<String, dynamic> data = json.decode(response.body);
      if (data['error'] != null) {
        mRespuesta['sCodigo'] = "0";
        mRespuesta['sMensaje'] = data['error'].toString();
      } else {
        mRespuesta['sCodigo'] = "1";
        mRespuesta['sMensaje'] = data['message'].toString();
        SharedPreferencesClass.writeData('token',data['token'] , "String");
      }
    } catch (e) {
      print('Error making HTTP request: $e');
      mRespuesta['sMensaje'] = "A ocurrido un error";
    }

    return Future.value(Future.sync(() => mRespuesta));
  }
}
