import 'package:app_see_game/class/AWS_S3.dart';
import 'package:app_see_game/iu/widgets/wd_appBarMain.dart';
import 'package:app_see_game/iu/widgets/wd_dialogos_alertas.dart';
import 'package:app_see_game/iu/widgets/wd_drawer.dart';
import 'package:app_see_game/models/mdl_publicacion.dart';
import 'package:app_see_game/services/svc_publicaciones.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_io/io.dart' as io;

// ...

class FormPublicacion extends StatefulWidget {
  const FormPublicacion({super.key});

  @override
  State<FormPublicacion> createState() => _FormPublicacionState();
}

String? validarCadenaVacia(String value, String key) {
  if (value.isEmpty) {
    return "El campo $key no debe estar vacio.";
  } else if (value.length < 3) {
    return "El campo $key debe tener por mínimo 3 caracteres.";
  } else {
    return null;
  }
}

class _FormPublicacionState extends State<FormPublicacion> {
  final GlobalKey<FormState> keyFormLoginPub = GlobalKey<FormState>();

  bool waiting = false;

  Publicacion publicacion = Publicacion();

  AWSS3 oAWSS3 = AWSS3();

  bool validarFormulario(GlobalKey<FormState> key) {
    if (key.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  List<PlatformFile> files = [];

  Future<void> _pickFiles() async {
    try {
      if (io.Platform.isAndroid || io.Platform.isIOS) {
        // Si estamos en una plataforma móvil, solicitar permisos
        final status = await Permission.storage.request();
        if (status != PermissionStatus.granted) {
          print('Permiso de almacenamiento denegado');
          return;
        }
      }
      setState(() {
        files = [];
      });
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'png', 'jpeg'],
          allowMultiple: true);

      if (result != null) {
        setState(() {
          if (result.files.length <= 3) {
            files = result.files;
          }
        });
      }
    } catch (e) {
      print('Error al seleccionar archivos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMain(),
      drawer: DrawerMain(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: SizedBox(
              width: double.infinity,
              child: Form(
                  key: keyFormLoginPub,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // ******************************    Texto "Inicio sesión"
                        const Text("Nueva publicación",
                            style: TextStyle(fontSize: 30)),
                        // ******************************    Espaciado
                        const SizedBox(
                          height: 30,
                        ),
                        // ******************************    Input usuario
                        TextFormField(
                          validator: (value) =>
                              validarCadenaVacia(value!, "nombre publicación"),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100))),
                              labelText: "Nombre publicación",
                              hintText: "Mi videojuego favorito."),
                          onChanged: (value) {
                            publicacion.sNombrePublicacion = value;
                          },
                        ),
                        const SizedBox(height: 5),
                        Text("Mínimo de 3 caracteres.",
                            style: TextStyle(
                                color: Colors.blueGrey.shade700, fontSize: 12)),
                        const SizedBox(
                          height: 30,
                        ),
                        // ******************************   Input contraseña
                        TextFormField(
                          validator: (value) =>
                              validarCadenaVacia(value!, "descripción"),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100))),
                              labelText: "Descripción",
                              hintText:
                                  "El juego ... es mi favorito porque ..."),
                          onChanged: (value) {
                            publicacion.sDescripcion = value;
                          },
                        ),
                        const SizedBox(height: 5),
                        Text("Mínimo de 3 caracteres.",
                            style: TextStyle(
                                color: Colors.blueGrey.shade700, fontSize: 12)),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: () async {
                                  _pickFiles();
                                },
                                child: const Text('Seleccionar Archivos'),
                              ),
                              const SizedBox(height: 5),
                              Text("Máximo 3 archivos.",
                                  style: TextStyle(
                                      color: Colors.blueGrey.shade700,
                                      fontSize: 12)),
                              const SizedBox(height: 20),
                              Text(
                                  'Archivos seleccionados: ${files.length.toString()}'),
                              // for (var file in _files) Text(file.name),
                            ],
                          ),
                        ),
                        // ******************************    Espaciado
                        const SizedBox(
                          height: 20,
                        ),
                        // ******************************   Boton enviar
                        ElevatedButton(
                            onPressed: () async {
                              if (validarFormulario(keyFormLoginPub)) {
                                setState(() {
                                  waiting = true;
                                });
                                Map<String, String> mRespuesta = {};

                                print(await publicacion);
                                publicacion.sIdUsuario =
                                    "65167157f40272e8e3b4f7b1";
                                publicacion.sUsuario = "w";
                                mRespuesta =
                                    await SvcPublicaciones.crearPublicacion(
                                        await publicacion);
                                if (files.isNotEmpty &&
                                    mRespuesta["sMensaje"] != "-1") {
                                  String sIDPublicacion =
                                      mRespuesta["sMensaje"]!;
                                  List<String> aURLImagenes = [];

                                  aURLImagenes =
                                      await oAWSS3.uploadFilesToS3(files);
                                  if (aURLImagenes.isNotEmpty) {
                                    publicacion.aUrlImagen = aURLImagenes;
                                    publicacion.sIDPublicacion = sIDPublicacion;
                                    mRespuesta = await SvcPublicaciones
                                        .actualizarImagePublicacion(
                                            await publicacion);
                                  }
                                } else {
                                  // TODO: Eliminar la publicación
                                }

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
                                      titulo: "Correcto",
                                      mensaje:
                                          "Publicación creada correctamente",
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
