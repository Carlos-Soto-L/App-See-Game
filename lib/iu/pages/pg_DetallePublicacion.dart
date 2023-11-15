import 'package:app_see_game/iu/widgets/wd_ListarComentarios.dart';
import 'package:app_see_game/iu/widgets/wd_ListarPublicaciones.dart';
import 'package:flutter/material.dart';

class DetallePublicacion extends StatefulWidget {
  const DetallePublicacion({Key? key}) : super(key: key);

  @override
  State<DetallePublicacion> createState() => _DetallePublicacionState();
}

class _DetallePublicacionState extends State<DetallePublicacion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Publicacion 1"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
          ListarPublicaciones(bBotonComentarios: false),

            Divider(),
            // Lista de comentarios}
            ListarComentarios(),
           
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return _buildBottomSheetContent(context);
            },
          );
        },
        child: Icon(Icons.comment),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildBottomSheetContent(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.8,
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    labelText: "Comentario",
                  ),
                ),
                Container(
                  alignment: AlignmentDirectional.topEnd,
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: TextButton(
                      child: const Text('Enviar'),
                      onPressed: () {/* ... */},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
