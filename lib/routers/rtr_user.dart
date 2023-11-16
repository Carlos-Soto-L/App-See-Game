import 'package:app_see_game/class/SharedPreferences.dart';
import 'package:app_see_game/iu/pages/pg_Acerca.dart';
import 'package:app_see_game/iu/pages/pg_DetallePublicacion.dart';
import 'package:app_see_game/iu/pages/pg_Eventos.dart';
import 'package:app_see_game/iu/pages/pg_PerfilUser.dart';
import 'package:app_see_game/iu/pages/pg_TermCondiciones.dart';
import 'package:app_see_game/iu/pages/pg_Videojuegos.dart';
import 'package:app_see_game/iu/pages/pg_homeUsuario.dart';
import 'package:app_see_game/iu/pages/pg_inicio.dart';
import 'package:app_see_game/iu/pages/pg_login.dart';
import 'package:flutter/material.dart';
import 'package:app_see_game/iu/pages/pg_registro.dart';

class UserRouters {
  static FutureBuilder comprobarSesion(Widget wPageTrue, Widget wPageFalse) {
    return FutureBuilder<dynamic>(
      future: SharedPreferencesClass.readData('token', "String"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError || snapshot.data == null) {
            // Manejar el error o la ausencia de datos aquí
            return wPageFalse;
          } else {
            return wPageTrue;
          }
        } else {
          // Puedes retornar un indicador de carga o cualquier otro widget temporal
          return CircularProgressIndicator();
        }
      },
    );
  }

  static Map<String, Widget Function(BuildContext)> routers() {
    Map<String, Widget Function(BuildContext)> userRouters = {
      'rtrRegistro': (contexto) {
        return comprobarSesion(HomeUsuario(), Registro());
      },
      'rtrInicio': (contexto) {
        return comprobarSesion(HomeUsuario(), Inicio());
      },
      'rtrLogin': (contexto) {
        return comprobarSesion(HomeUsuario(), Login());
      },
      'rtrHomeUsuario': (contexto) {
        return comprobarSesion(HomeUsuario(), Inicio());
      },
      'rtrPerfilUser': (contexto) {
        return comprobarSesion(PerfilUser(), Inicio());
      },
      'rtrDetallePublicacion': (contexto) {
        return comprobarSesion(DetallePublicacion(), Inicio());
      },
      'rtrVideojuegos': (contexto) {
        return comprobarSesion(Videojuegos(), Inicio());
      },
      'rtrEventos': (contexto) {
        return comprobarSesion(Eventos(), Inicio());
      },
      'rtrTermCondiciones': (contexto) {
        return comprobarSesion(TermCondiciones(), Inicio());
      },
      'rtrAcercaDe': (contexto) {
        return comprobarSesion(Acerca(), Inicio());
      },
    };

    return userRouters;
  }
}
