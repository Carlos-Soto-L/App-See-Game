// import 'package:http/http.dart' as http;

import 'package:app_see_game/class/SharedPreferences.dart';
import 'package:app_see_game/models/mdl_publicacion.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SvcPublicaciones {


  // static Future<Map<String, String>> getPublicaciones({String? sIdPublicacion}) async {
  //   Map<String, String> mRespuesta = {"sCodigo": "0", "sMensaje": ""};
  //   var url =
  //       Uri.https("${dotenv.env['HOST']!}:${dotenv.env['PORT']!}", '/users/verPublicacion');

  //   print(url);
  //   try {
  //     var response =
  //         await http.get(url,
  //          headers: {'authorization': SharedPreferencesClass.readData('token', "String").toString() });
  //     print('Response status: ${response.statusCode}');
  //     print('Response body: ${response.body}');
  //     Map<String, dynamic> data = json.decode(response.body);
  //     if (data['error'] != null) {
  //       mRespuesta['sCodigo'] = "0";
  //       mRespuesta['sMensaje'] = data['error'].toString();
  //     } else {
  //       mRespuesta['sCodigo'] = "1";
  //       mRespuesta['sMensaje'] = data['message'].toString();
  //       SharedPreferencesClass.writeData('token',data['token'] , "String");
  //     }
  //   } catch (e) {
  //     print('Error making HTTP request: $e');
  //     mRespuesta['sMensaje'] = "A ocurrido un error";
  //   }

  //   return Future.value(Future.sync(() => mRespuesta));
  // }

    static Future<Map<String, String>> crearPublicacion(Publicacion publicacion) async {
    Map<String, String> mRespuesta = {"sCodigo": "0", "sMensaje": ""};
    var url =
        Uri.http("${dotenv.env['HOST']!}:${dotenv.env['PORT']!}", '/users/crearPublicacion');

    print(url);
    try {
      String sToken = await SharedPreferencesClass.readData('token', "String");
      print(await Publicacion.serializacion(publicacion).runtimeType);

      var response =
          await http.post(url, body: await Publicacion.serializacion(publicacion),headers: {
            "Authorization": sToken
          });
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      Map<String, dynamic> data = json.decode(response.body);
      if (data['error'] != null) {
        mRespuesta['sCodigo'] = "0";
        mRespuesta['sMensaje'] = "-1";
      } else {
        mRespuesta['sCodigo'] = "1";
        mRespuesta['sMensaje'] = data['messge'].toString();
      }
      print("Respuesta: $mRespuesta");
    } catch (e) {
      print('Error making HTTP request: $e');
      mRespuesta['sMensaje'] = "-1";
    }

    

    return Future.value(Future.sync(() => mRespuesta));
  }


    static Future<Map<String, String>> actualizarImagePublicacion(Publicacion publicacion) async {
    Map<String, String> mRespuesta = {"sCodigo": "0", "sMensaje": ""};
    var url =
        Uri.http("${dotenv.env['HOST']!}:${dotenv.env['PORT']!}", '/users/actualizarImagenPub');

    print(url);
    try {
      String sToken = await SharedPreferencesClass.readData('token', "String");
      var response =
          await http.post(url, body: await Publicacion.serializacionActualizarImagen(publicacion),headers: {
            "Authorization": sToken
          });
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      Map<String, dynamic> data = json.decode(response.body);
      if (data['error'] != null) {
        mRespuesta['sCodigo'] = "0";
        mRespuesta['sMensaje'] = "-1";
      } else {
        mRespuesta['sCodigo'] = "1";
        mRespuesta['sMensaje'] = data['messge'].toString();
      }
      print("Respuesta: $mRespuesta");
    } catch (e) {
      print('Error making HTTP request: $e');
      mRespuesta['sMensaje'] = "A ocurrido un error";
    }

    

    return Future.value(Future.sync(() => mRespuesta));
  }
}
