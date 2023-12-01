import 'package:app_see_game/class/Utils.dart';
import 'package:app_see_game/iu/widgets/wd_ListarComentarios.dart';
import 'package:app_see_game/iu/widgets/wd_drawer.dart';
import 'package:app_see_game/services/API/svs_videojuegos.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:getwidget/getwidget.dart';

class DetalleJuego extends StatefulWidget {
  const DetalleJuego({super.key});

  @override
  State<DetalleJuego> createState() => _DetalleJuegoState();
}

class _DetalleJuegoState extends State<DetalleJuego> {
  bool waiting = true;
  List<Map<String, dynamic>> aInformacion = [];
  // Inicializa sNombre con un valor predeterminado
  late String sIDJuego = "";

  // Información:
  List<dynamic> imageList = [];

  List<String> videoControllers = [];

  String historia = "";
  String resumen = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Accede a los argumentos de la ruta en didChangeDependencies
    sIDJuego = (ModalRoute.of(context)?.settings.arguments as String?) ?? '';

    if (!sIDJuego.isEmpty) {
      _loadData(sIDJuego);
    }
  }

  Future<void> _loadData(String sIDJuego) async {
    setState(() {
      waiting = true;
    });

    // Llama a tu función asíncrona aquí
    List<Map<String, dynamic>> aRespuesta =
        await SvcVideojuegos.getDetalleJuego(sIDJuego);

    setState(() {
      aInformacion = aRespuesta;
      imageList = aInformacion[0]['screenshots'] ?? [];
      if (imageList.length >= 1) {
        imageList = aInformacion[0]['screenshots']
            .map((screenshot) => screenshot['urlOriginal'] as String)
            .toList();
      }
      List<dynamic> videos = aInformacion[0]['videos'] ?? [];
      if (videos.isNotEmpty) {
        for (var video in videos) {
          String urlYoutube = video['urlYoutube'];
          String? videoId = Utils.extractVideoId(urlYoutube);
          print('El ID del video ${video['name']} es: $videoId');
          if (videoId != null) {
            videoControllers.add(videoId);
          }
        }
      }

      // Obtener historia juego
      historia = aInformacion[0]['storyline'] ?? "";

      // Obtener resumen juego
      resumen = aInformacion[0]['summary'] ?? "";

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
        appBar: AppBar(
          title: Text(!waiting ? aInformacion[0]['name'] : 'Cargando ...'),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        drawer: const DrawerMain(),
        body:
            // Center(
            //     child:
            SingleChildScrollView(
                child: Container(
                    alignment: Alignment.topLeft,
                    constraints: BoxConstraints(maxWidth: screenWidth),
                    child: Center(
                      child: Container(
                        // alignment: Alignment.topLeft,
                        constraints: BoxConstraints(maxWidth: maxWidth),
                        child: Column(
                          children: [
                            if (!waiting)
                              if (imageList.isNotEmpty)
                                GFCarousel(
                                  items: imageList.map(
                                    (url) {
                                      return Container(
                                        margin: EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          child: Image.network(url,
                                              fit: BoxFit.cover,
                                              width: maxWidth),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                  autoPlay: true,
                                  viewportFraction: 1.0,
                                  autoPlayAnimationDuration:
                                      Duration(milliseconds: 400),
                                  onPageChanged: (index) {
                                    setState(() {
                                      index;
                                    });
                                  },
                                ),

                            if (historia.isNotEmpty)
                              GFAccordion(
                                  title: 'Historia',
                                  content: historia,
                                  showAccordion: true,
                                  collapsedIcon: const Icon(Icons.add),
                                  expandedIcon: const Icon(Icons.minimize)),
                            if (resumen.isNotEmpty)
                              GFAccordion(
                                  title: 'Resumen',
                                  content: resumen,
                                  showAccordion: true,
                                  collapsedIcon: const Icon(Icons.add),
                                  expandedIcon: const Icon(Icons.minimize)),
                            if(!waiting && resumen.isEmpty && historia.isEmpty)
                            Text("Sin información."),
                            if (videoControllers.isNotEmpty)
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                child: YoutubePlayer(
                                  controller:
                                      YoutubePlayerController.fromVideoId(
                                    videoId: videoControllers[0],
                                    autoPlay: false,
                                    params: const YoutubePlayerParams(
                                      showControls: true,
                                      showFullscreenButton: false,
                                    ),
                                  ),
                                  aspectRatio:
                                      screenWidth > 500 ? 16 / 9 : 4 / 3,
                                ),
                              ),
                            if (!waiting)
                              const Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                  ),
                                  ListarComentarios(),
                                  SizedBox(
                                    height: 100,
                                  ),
                                ],
                              ),
                            
                            if (waiting)
                              Container(
                                child: Center(
                                  child:
                                      LoadingAnimationWidget.staggeredDotsWave(
                                    color: Theme.of(context).primaryColor,
                                    size: 60,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      // )
                    ))));
  }
}
