import 'package:app_see_game/iu/widgets/wd_appBarMain.dart';
import 'package:app_see_game/iu/widgets/wd_drawer.dart';
import 'package:flutter/material.dart';

class TermCondiciones extends StatefulWidget {
  const TermCondiciones({super.key});

  @override
  State<TermCondiciones> createState() => _TermCondicionesState();
}

class _TermCondicionesState extends State<TermCondiciones> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMain(),
      drawer: DrawerMain(),
    );
  }
}
