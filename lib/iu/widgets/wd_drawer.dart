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
            title: const Text("Perfil"),
            leading: Icon(Icons.account_circle),
            onTap: () {
              Navigator.of(context).pushNamed('rtrPerfilUser');
            },
          ),
          ListTile(
            title: const Text("Videojuegos"),
            leading: Icon(Icons.videogame_asset_rounded),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Eventos"),
            leading: Icon(Icons.event),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
