import 'package:app_see_game/iu/widgets/wd_ListarPublicaciones.dart';
import 'package:app_see_game/iu/widgets/wd_appBarMain.dart';
import 'package:app_see_game/iu/widgets/wd_drawer.dart';
import 'package:flutter/material.dart';

class PerfilUser extends StatefulWidget {
  const PerfilUser({super.key});

  @override
  State<PerfilUser> createState() => _PerfilUserState();
}

class _PerfilUserState extends State<PerfilUser> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const AppBarMain(),
      drawer: const DrawerMain(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListarPublicaciones(),
            ],
          ),
        ),
      ),
    );
  }
}