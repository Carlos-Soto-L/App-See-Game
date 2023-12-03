
import 'dart:convert';

class Publicacion {
  String? sIDPublicacion = "";
  String? sIdUsuario = "";
  String? sUsuario = "";
  String? sNombrePublicacion = "";
  String? sDescripcion = "";
  List<dynamic>? aUrlImagen = [];
  String? sFecha = "";

  Publicacion({this.sUsuario, this.sNombrePublicacion, this.sDescripcion, this.aUrlImagen, this.sFecha, this.sIdUsuario});

// TODO: Arreglar el mapeo
  static Future<Map<String, dynamic>> serializacion(Publicacion pub) async{
    return Future.value(Future<Map<String, dynamic>>.sync(() => {
          'userid': pub.sIdUsuario ?? "",
          'nickname': pub.sUsuario ?? "",
          'nombrePublicacion': pub.sNombrePublicacion ?? "",
          'descripcion': pub.sDescripcion ?? "",
          'urlImagen': jsonEncode(pub.aUrlImagen ?? []),
        }));
  }

    static Future<Map<String, dynamic>> serializacionActualizarImagen(Publicacion pub) async{
    return Future.value(Future<Map<String, dynamic>>.sync(() => {
          'idPublicacion': pub.sIDPublicacion ?? "",
          'urlsImagenes': jsonEncode(pub.aUrlImagen ?? []),
        }));
  }
}
