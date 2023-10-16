import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Dialogo {
  Dialogo._();

  static Future<void> mostrarAlertaError(
      {required BuildContext context,
      required String titulo,
      required String mensaje}) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(titulo,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Center(
                    child: Icon(MdiIcons.alert, size: 90, color: Colors.red),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    mensaje,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  static Future<void> mostrarAlertaCorrecto(
      {required BuildContext context,
      required String titulo,
      required String mensaje,
      String? sRuta}) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(titulo,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Center(
                    child: Icon(MdiIcons.accountGroup,
                        size: 90, color: Colors.green),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    mensaje,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Aceptar'),
                onPressed: () {
                  if (sRuta == null) {
                    Navigator.of(context).pop();
                  }else{
                    Navigator.of(context).pushNamed(sRuta);
                  }
                },
              ),
            ],
          );
        });
  }
}
