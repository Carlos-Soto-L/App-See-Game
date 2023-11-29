import 'package:app_see_game/iu/widgets/wd_appBarMain.dart';
import 'package:app_see_game/iu/widgets/wd_drawer.dart';
import 'package:app_see_game/services/API/svs_videojuegos.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:getwidget/getwidget.dart';

class Videojuegos extends StatefulWidget {
  const Videojuegos({super.key});

  @override
  State<Videojuegos> createState() => _VideojuegosState();
}

class _VideojuegosState extends State<Videojuegos> {
  bool waiting = true;
  List<Map<String, dynamic>> videojuegos = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      waiting = true;
    });

    // Llama a tu función asíncrona aquí
    List<Map<String, dynamic>> aRespuesta =
        await SvcVideojuegos.getVideojuegos();

    setState(() {
      videojuegos = aRespuesta;
      waiting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
        // Obtén el ancho total de la pantalla
    double screenWidth = MediaQuery.of(context).size.width;

    // Establece el ancho máximo como un porcentaje (80% en este caso)
    double maxWidthPercentage = 0.7;
    double maxWidth = screenWidth * maxWidthPercentage;
    maxWidth = screenWidth > 500 ? maxWidth : screenWidth;

    return Scaffold(
        appBar: AppBarMain(),
        drawer: DrawerMain(),
        body: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Stack(
              children: [
                if (!waiting)
                  ListView.builder(
                    itemCount: videojuegos.length,
                    itemBuilder: (context, index) {
                      print(videojuegos.length);
                      return GFListTile(
                        color: Theme.of(context).cardColor,
                        hoverColor: Theme.of(context).hoverColor,
                        focusColor: Theme.of(context).focusColor,
                        titleText: videojuegos[index]['name'],
                        icon: const Icon(Icons.videogame_asset_rounded),
                        onTap: () {
                          print('ID: ${videojuegos[index]['id']}');
                        },
                      );
                    },
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
          ),
        ));
  }
}
