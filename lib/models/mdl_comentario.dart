
class Comentario {
  String? sIdPublicacion = "";
  String? sUsuario = "";
  String? sComentario = "";
  String? sFecha = "";

  Comentario({this.sIdPublicacion, this.sUsuario, this.sComentario, this.sFecha});

  static Future<Map<String, dynamic>> serializacion(Comentario coment) {
    return Future.value(Future<Map<String, dynamic>>.sync(() => {
          'idPublicacion': coment.sIdPublicacion ?? "",
          'user': coment.sUsuario ?? "",
          'comentario': coment.sComentario ?? "",
          'fecha': coment.sFecha ?? ""
        }));
  }
}