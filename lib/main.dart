import 'package:app_see_game/iu/pages/pg_inicio.dart';
import 'package:app_see_game/routers/rtr_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(
      fileName:
          ".env"); // mergeWith optional, you can include Platform.environment for Mobile/Desktop app

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      routes: UserRouters.routers(),
      home: Inicio(),
    );
  }
}
