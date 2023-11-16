import 'package:flutter/material.dart';

class DrawerMain extends StatelessWidget {
  const DrawerMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            title: const Text("Inicio"),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.of(context).pushNamed('rtrHomeUsuario');
            },
          ),
          ListTile(
            title: const Text("Videojuegos"),
            leading: Icon(Icons.videogame_asset_rounded),
            onTap: () {
              Navigator.of(context).pushNamed('rtrVideojuegos');
            },
          ),
          ListTile(
            title: const Text("Eventos"),
            leading: Icon(Icons.event),
            onTap: () {
              Navigator.of(context).pushNamed('rtrEventos');
            },
          ),
          ListTile(
            title: const Text("Acerca de"),
            leading: const Icon(Icons.business_sharp),
            onTap: () {
              Navigator.of(context).pushNamed('rtrAcercaDe');
            },
          ),
          ListTile(
            title: const Text("Terminos y condiciones"),
            leading: const Icon(Icons.balance),
            onTap: () {
              Navigator.of(context).pushNamed('rtrTermCondiciones');
            },
          )
        ],
      ),
    );
  }
}
