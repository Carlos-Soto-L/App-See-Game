import 'package:app_see_game/iu/widgets/wd_appBarMain.dart';
import 'package:app_see_game/iu/widgets/wd_drawer.dart';
import 'package:app_see_game/services/API/svs_videojuegos.dart';
import 'package:flutter/material.dart';

class Videojuegos extends StatefulWidget {
  const Videojuegos({super.key});

  @override
  State<Videojuegos> createState() => _VideojuegosState();
}

class _VideojuegosState extends State<Videojuegos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMain(),
      drawer: DrawerMain(),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                await SvcVideojuegos.getVideojuegos();
              },
              child: Text("Prueba"))
        ],
      ),
    );
  }
}
