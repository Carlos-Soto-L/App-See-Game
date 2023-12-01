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

  // Inicializa sNombre con un valor predeterminado
  late String sNombre = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Accede a los argumentos de la ruta en didChangeDependencies
    sNombre = (ModalRoute.of(context)?.settings.arguments as String?) ?? '';

    if (sNombre.isEmpty) {
      _loadData();
      
    } else {
      _loadDataSearch(sNombre);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

  Future<void> _loadDataSearch(String sNombre) async {
    setState(() {
      waiting = true;
    });

    // Llama a tu función asíncrona aquí
    List<Map<String, dynamic>> aRespuesta =
        await SvcVideojuegos.getVideojuegosSearch(sNombre);

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
        appBar: const AppBarMain(iControl: 1),
        drawer: const DrawerMain(),
        body: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Stack(
              children: [
                if (!waiting)
                  ListView.builder(
                    itemCount: videojuegos.length,
                    itemBuilder: (context, index) {
                      return GFListTile(
                        color: Theme.of(context).cardColor,
                        hoverColor: Theme.of(context).hoverColor,
                        focusColor: Theme.of(context).focusColor,
                        titleText: videojuegos[index]['name'],
                        icon: const Icon(Icons.videogame_asset_rounded),
                        onTap: () {
                          Navigator.of(context).pushNamed("rtrDetallesjuego", arguments: videojuegos[index]['id'].toString());
                        },
                      );
                    },
                  ),
                if (waiting)
                  Container(
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
