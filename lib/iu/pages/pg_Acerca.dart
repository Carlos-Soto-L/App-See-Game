import 'package:app_see_game/iu/widgets/wd_appBarMain.dart';
import 'package:app_see_game/iu/widgets/wd_drawer.dart';
import 'package:flutter/material.dart';

class Acerca extends StatefulWidget {
  const Acerca({super.key});

  @override
  State<Acerca> createState() => _AcercaState();
}

class _AcercaState extends State<Acerca> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMain(),
      drawer: DrawerMain(),
    );
  }
}
