import 'package:app_see_game/iu/widgets/wd_appBarMain.dart';
import 'package:app_see_game/iu/widgets/wd_drawer.dart';
import 'package:app_see_game/services/API/svs_videojuegos.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Videojuegos extends StatefulWidget {
  const Videojuegos({super.key});

  @override
  State<Videojuegos> createState() => _VideojuegosState();
}

class _VideojuegosState extends State<Videojuegos> {
  bool waiting = true;
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
    await SvcVideojuegos.getVideojuegos();

    setState(() {
      waiting = false;
    });
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
                child: Text("sdfs000"),
              )),
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
