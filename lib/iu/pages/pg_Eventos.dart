import 'package:app_see_game/iu/widgets/wd_appBarMain.dart';
import 'package:app_see_game/iu/widgets/wd_drawer.dart';
import 'package:app_see_game/services/API/svs_eventos.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Eventos extends StatefulWidget {
  const Eventos({super.key});

  @override
  State<Eventos> createState() => _EventosState();
}

class _EventosState extends State<Eventos> {
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
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      waiting = true;
    });

    // Llama a tu función asíncrona aquí
    List<Map<String, dynamic>> aRespuesta =
        await SvcEventos.getEventos();

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
        await SvcEventos.getEventosSearch(sNombre);

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
        appBar: AppBarMain(iControl: 2),
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
                        icon: const Icon(Icons.calendar_month),
                        onTap: () {
                          Navigator.of(context).pushNamed("rtrDetallesevento", arguments: videojuegos[index]['id'].toString());
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
