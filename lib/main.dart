import 'package:app_see_game/amplifyconfiguration.dart';
import 'package:app_see_game/iu/pages/pg_inicio.dart';
import 'package:app_see_game/routers/rtr_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

Future main() async {
  await dotenv.load(
      fileName:
          ".env"); // mergeWith optional, you can include Platform.environment for Mobile/Desktop app
  WidgetsFlutterBinding.ensureInitialized();

  await configureAmplify();
  runApp(const MyApp());
}

Future<void> configureAmplify() async {
  try {
    await Amplify.addPlugins([AmplifyStorageS3()]);
    AmplifyAuthCognito auth = AmplifyAuthCognito();

    Amplify.addPlugin(auth);
    await Amplify.configure(amplifyconfig);
    print("Amplify configurado correctamente");
  } catch (e) {
    print("Error al configurar Amplify: $e");
  }
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
