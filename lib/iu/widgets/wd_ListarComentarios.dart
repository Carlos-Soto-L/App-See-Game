import 'package:flutter/material.dart';

class ListarComentarios extends StatefulWidget {
  const ListarComentarios({super.key});

  @override
  State<ListarComentarios> createState() => _ListarComentariosState();
}

class _ListarComentariosState extends State<ListarComentarios> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 1, // Número de comentarios
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("Nombre"),
          subtitle: Text(
              "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas, las cuales contenian pasajes de Lorem Ipsum, y más recientemente con software de autoedición, como por ejemplo Aldus PageMaker, el cual incluye versiones de Lorem Ipsum."),
          leading: Icon(Icons.account_circle),
        );
      },
    );
  }
}
