import 'package:app_see_game/iu/widgets/wd_appBarMain.dart';
import 'package:app_see_game/iu/widgets/wd_drawer.dart';
import 'package:flutter/material.dart';

class HomeUsuario extends StatefulWidget {
  const HomeUsuario({super.key});

  @override
  State<HomeUsuario> createState() => _HomeUsuarioState();
}

class _HomeUsuarioState extends State<HomeUsuario> {
  


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const AppBarMain(),
      drawer: const DrawerMain(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  
}
