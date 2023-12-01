import 'package:app_see_game/class/Utils.dart';
import 'package:app_see_game/iu/widgets/wd_ListarComentarios.dart';
import 'package:app_see_game/iu/widgets/wd_drawer.dart';
import 'package:app_see_game/services/API/svs_eventos.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class DetalleEvento extends StatefulWidget {
  const DetalleEvento({super.key});

  @override
  State<DetalleEvento> createState() => _DetalleEventoState();
}

class _DetalleEventoState extends State<DetalleEvento> {
  bool waiting = true;
  List<Map<String, dynamic>> aInformacion = [];
  late String sIDEvento = "";

  List<dynamic> imageList = [];

  List<String> videoControllers = [];

  String description = "";

  String tituloVideo = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Accede a los argumentos de la ruta en didChangeDependencies
    sIDEvento = (ModalRoute.of(context)?.settings.arguments as String?) ?? '';

    if (!sIDEvento.isEmpty) {
      _loadData(sIDEvento);
    }
  }

  Future<void> _loadData(String sIDJuego) async {
    setState(() {
      waiting = true;
    });

    // Llama a tu función asíncrona aquí
    List<Map<String, dynamic>> aRespuesta =
        await SvcEventos.getDetalleEvento(sIDJuego);

    setState(() {
      aInformacion = aRespuesta;
      imageList = aInformacion[0]['event_logo'] ?? [];
      if (imageList.length >= 1) {
        imageList = aInformacion[0]['event_logo']
            .map((screenshot) => screenshot['urlOriginal'] as String)
            .toList();
      }
      List<dynamic> videos = aInformacion[0]['videos'] ?? [];
      if (videos.isNotEmpty) {
        for (var video in videos) {
          String urlYoutube = video['urlYoutube'];
          String? videoId = Utils.extractVideoId(urlYoutube);
          tituloVideo = video['name'] ?? "video";
          print('El ID del video ${video['name']} es: $videoId');
          if (videoId != null) {
            videoControllers.add(videoId);
            break;
          }
        }
      }

      description = aInformacion[0]['description'] ?? "";

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
                            if (description.isNotEmpty)
                              GFAccordion(
                                  title: 'Descripción',
                                  content: description,
                                  showAccordion: true,
                                  collapsedIcon: const Icon(Icons.add),
                                  expandedIcon: const Icon(Icons.minimize)),
                            if (!waiting &&
                                videoControllers.isEmpty &&
                                description.isEmpty)
                              Text("Sin información."),
                            if (videoControllers.isNotEmpty && !waiting)
                              ElevatedButton(
                                  onPressed: () {
                                    showDialog<void>(
                                        context: context,
                                        barrierDismissible:
                                            false, // user must tap button!
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                              tituloVideo,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            content: Container(
                                              // Establece un tamaño fijo para el contenido del video
                                              width:
                                                  screenWidth, // Ajusta este valor según tus necesidades
                                              // height:
                                              //     1000, // Ajusta este valor según tus necesidades
                                              child: YoutubePlayer(
                                                controller:
                                                    YoutubePlayerController
                                                        .fromVideoId(
                                                  videoId: videoControllers[0],
                                                  autoPlay: false,
                                                  params:
                                                      const YoutubePlayerParams(
                                                    showControls: true,
                                                    showFullscreenButton: true,
                                                  ),
                                                ),
                                                aspectRatio: 16 /
                                                    9, // Ajusta este valor según tus necesidades
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('Cerrar'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: Text("Mostrar video")),
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
