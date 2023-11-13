import 'package:app_see_game/iu/widgets/wd_dialogos_alertas.dart';
import 'package:app_see_game/models/mdl_usuario.dart';
import 'package:app_see_game/services/svc_autenticacion.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

String? validarCadenaVacia(String value, String key) {
  if (value.isEmpty) {
    return "El campo $key no debe ser vacio.";
  } else {
    return null;
  }
}

class _LoginState extends State<Login> {
  Usuario usuario = Usuario();

  final GlobalKey<FormState> keyFormLogin = GlobalKey<FormState>();

  bool waiting = false;

  bool validarFormulario(GlobalKey<FormState> key) {
    if (key.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: SizedBox(
              width: double.infinity,
              child: Form(
                  key: keyFormLogin,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // ******************************    Texto "Inicio sesión"
                        const Text("Iniciar sesión",
                            style: TextStyle(fontSize: 30)),
                        // ******************************    Espaciado
                        const SizedBox(
                          height: 30,
                        ),
                        // ******************************    Input usuario
                        TextFormField(
                          validator: (value) =>
                              validarCadenaVacia(value!, "Usuario"),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100))),
                              labelText: "Usuario",
                              hintText: "Ej. Nano27c"),
                          onChanged: (value) {
                            usuario.sUsuario = value;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        // ******************************   Input contraseña
                        TextFormField(
                          validator: (value) =>
                              validarCadenaVacia(value!, "Contraseña"),
                          obscureText: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100))),
                              labelText: "Contraseña"),
                          onChanged: (value) {
                            usuario.sPassword = value;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        // ******************************    Espaciado
                        const SizedBox(
                          height: 20,
                        ),
                        // ******************************   Boton enviar
                        ElevatedButton(
                            onPressed: () async {
                              if (validarFormulario(keyFormLogin)) {
                                setState(() {
                                  waiting = true;
                                });
                                Map<String, String> mRespuesta =
                                    await SvcAutenticacion.loginUsuario(
                                        usuario);
                                setState(() {
                                  waiting = false;
                                });

                                if (mRespuesta['sCodigo'] == "0") {
                                  Dialogo.mostrarAlertaError(
                                      context: context,
                                      titulo: "Información",
                                      mensaje: mRespuesta['sMensaje']!);
                                } else {
                                  Dialogo.mostrarAlertaCorrecto(
                                      context: context,
                                      titulo: "Bienvenido",
                                      mensaje: "${usuario.sUsuario}",
                                      sRuta: "rtrHomeUsuario");
                                }
                              }
                            },
                            child: const Text("Enviar")),
                        // ******************************    Espaciado
                        const SizedBox(
                          height: 20,
                        ),
                        // ******************************   Boton regresar
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed("rtrInicio");
                            },
                            child: const Text("Regresar")),
                      ],
                    ),
                  )),
            ),
          ),
          // ******************************   Elementos de carga
          if (waiting)
            Container(
              color: Colors.black.withOpacity(0.2),
              child: Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Theme.of(context).primaryColor,
                  size: 60,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
