import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Theme.of(context).secondaryHeaderColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100))),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton.icon(
                    icon: Icon(MdiIcons.account),
                    onPressed: () {
                      Navigator.of(context).pushNamed('rtrLogin');
                    },
                    label: const Text("Inciar sesión"),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton.icon(
                    icon: Icon(MdiIcons.accountPlus),
                    onPressed: () {
                      Navigator.of(context).pushNamed('rtrRegistro');
                    },
                    label: const Text("Crea una cuenta"),
                  )
                ],
              ),
            )));
  }
}
