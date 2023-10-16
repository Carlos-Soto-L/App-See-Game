
class Usuario {
  String? sNombre = "";
  String? sApellido = "";
  String? sUsuario = "";
  String? sCorreo = "";
  String? sPassword = "";

  Usuario({this.sNombre, this.sApellido, this.sCorreo, this.sPassword});

  static Future<Map<String, dynamic>> serializacion(Usuario usuario) {
    return Future.value(Future<Map<String, dynamic>>.sync(() => {
          'nombre': usuario.sNombre,
          'apellido': usuario.sApellido,
          'username': usuario.sUsuario,
          'email': usuario.sCorreo,
          'password': usuario.sPassword
        }));
  }
}
