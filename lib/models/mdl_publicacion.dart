
class Publicacion {
  String? sIdUsuario = "";
  String? sUsuario = "";
  String? sNombrePublicacion = "";
  String? sDescripcion = "";
  String? sJuegoPublicado = "";
  String? sCategoria = "";
  String? sFecha = "";

  Publicacion({this.sUsuario, this.sNombrePublicacion, this.sDescripcion, this.sJuegoPublicado, this.sCategoria});

// TODO: Arreglar el mapeo
  static Future<Map<String, dynamic>> serializacion(Publicacion pub) {
    return Future.value(Future<Map<String, dynamic>>.sync(() => {
          'user': pub.sIdUsuario ?? "",
          'nombrePublicacion': pub.sNombrePublicacion ?? "",
          'descripcion': pub.sDescripcion ?? "",
          'juegoPublicado': pub.sJuegoPublicado ?? "",
          'categoria': pub.sCategoria ?? ""
        }));
  }
}
