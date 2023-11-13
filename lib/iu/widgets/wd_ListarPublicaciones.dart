import 'package:flutter/material.dart';

class ListarPublicaciones extends StatefulWidget {
      bool __bButonComentarios = true;
  String __sIdPublicacion = "";
ListarPublicaciones({super.key, bool? bBotonComentarios, String? sIdPublicacion}){
    print(__bButonComentarios);
    __bButonComentarios = bBotonComentarios ?? true;
    __sIdPublicacion = sIdPublicacion ?? "";
  }

  @override
  State<ListarPublicaciones> createState() => _ListarPublicacionesState();
}

class _ListarPublicacionesState extends State<ListarPublicaciones> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 1, // Número de comentarios
      itemBuilder: (context, index) {
        return Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const ListTile(
                      leading: Icon(Icons.album),
                      title: Text('The Enchanted Nightingale'),
                      subtitle:
                          Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "En este ejemplo, he agregado una implementación para el getter preferredSize al final de la clase. El valor devuelto Size.fromHeight(kToolbarHeight) es un valor común para la altura preferida de una barra de herramientas estándar en Flutter. Puedes ajustar esto según tus necesidades específicas. Además, he corregido la declaración del constructor para usar Key? key en lugar de super.key, ya que parece que quisieras utilizar el parámetro de clave del constructor. Asegúrate de que esta modificación sea consistente con tu intención original. Con estas correcciones, deberías poder resolver el error mencionado.",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Image.network(
                      "https://storage.googleapis.com/cms-storage-bucket/70760bf1e88b184bb1bc.png",
                      fit: BoxFit.cover,
                    ),
                    if(widget.__bButonComentarios)
                    Container(
                      alignment: AlignmentDirectional.topEnd,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: TextButton(
                          child: const Text('Comentarios'),
                          onPressed: () {
                            Navigator.of(context).pushNamed('rtrDetallePublicacion');
                          },
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
