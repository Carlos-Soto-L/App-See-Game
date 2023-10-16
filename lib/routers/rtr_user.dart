
import 'package:app_see_game/iu/pages/pg_inicio.dart';
import 'package:flutter/material.dart';
import 'package:app_see_game/iu/pages/pg_registro.dart';

class UserRouters {

  static Map<String, Widget Function(BuildContext)> routers(){
    Map<String, Widget Function(BuildContext)> userRouters = {
      'rtrRegistro': (contexto) => Registro(),
      'rtrInicio': (contexto) => const Inicio()
    };

    return userRouters;

  }
}