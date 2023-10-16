import 'package:app_see_game/iu/widgets/wd_dialogos_alertas.dart';
import 'package:app_see_game/models/mdl_usuario.dart';
import 'package:app_see_game/services/svc_registro.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Registro extends StatefulWidget {
  Registro({super.key});

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  final Usuario usuario = Usuario();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool waiting = false;

  String? validarCadenaVacia(String? value, String key) {
    if (value == null || value.isEmpty) {
      return "El campo $key no debe estar vacio.";
    } else {
      return null;
    }
  }

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
                key: formkey,
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    Column(
                      children: [
                        const Text("Crear cuenta",
                            style: TextStyle(fontSize: 30)),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          validator: (value) =>
                              validarCadenaVacia(value!, "Nombre"),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100))),
                              labelText: "Nombre",
                              hintText: "Ej. Marco"),
                          onChanged: (value) {
                            usuario.sNombre = value;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          validator: (value) =>
                              validarCadenaVacia(value!, "Apellido"),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100))),
                              labelText: "Apellido",
                              hintText: "Ej. Hernandez"),
                          onChanged: (value) {
                            usuario.sApellido = value;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          validator: (value) =>
                              validarCadenaVacia(value!, "Usuario"),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100))),
                              labelText: "Nombre de usuario",
                              hintText: "Ej. User23c"),
                          onChanged: (value) {
                            usuario.sUsuario = value;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          validator: (value) =>
                              validarCadenaVacia(value!, "Correo"),
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100))),
                              labelText: "Correo",
                              hintText: "Ej. seegame@gmail.com"),
                          onChanged: (value) {
                            usuario.sCorreo = value;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          validator: (value) =>
                              validarCadenaVacia(value!, "Contraseña"),
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                            labelText: "Contraseña",
                          ),
                          onChanged: (value) {
                            usuario.sPassword = value;
                          },
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        ElevatedButton.icon(
                            onPressed: () async {
                              if (validarFormulario(formkey)) {
                                setState(() {
                                  waiting = true;
                                });
                                Map<String, String> mRespuesta =
                                    await SvcRegistro.registrarUsuario(usuario);
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
                                      mensaje: "${usuario.sNombre} ${usuario.sApellido}",sRuta: "rtrInicio");
                                }
                              }
                            },
                            icon: Icon(MdiIcons.send),
                            label: const Text("Enviar")),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context).pushNamed('rtrInicio');
                            },
                            icon: Icon(MdiIcons.arrowLeft),
                            label: const Text("Regresar")),
                      ],
                    )
                  ],
                )),
              ),
            ),
          ),
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
