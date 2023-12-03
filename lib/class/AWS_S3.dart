import 'dart:typed_data';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_io/io.dart' as io;

class AWSS3 {
//   Future<void> uploadFilesToS3(List<PlatformFile> files) async {
//   try {
//     print("Entrooo");
//     for (var file in files) {
//       print(file.name);
//       final key = "Publicaciones/${file.name}"; // Reemplaza con la ruta deseada en S3

//       const options = StorageUploadFileOptions(accessLevel: StorageAccessLevel.guest);
//       final result = await Amplify.Storage.uploadFile(
//         localFile: AWSFile.fromPath(file.path!),
//         key: key,
//         options: options,
//       );

//       print("Archivo subido correctamente a $key");
//     }
//   } catch (e) {
//     print("Error al subir archivos a S3: $e");
//   }
// }

  Future<List<String>> uploadFilesToS3(List<PlatformFile> files) async {
    List<String> aUrlImagenes = [];
    try {
      print("Entrooo");
      for (var file in files) {
        print(file.name);
        DateTime now = DateTime.now();
        String formattedDateTime =
            "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}_${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}_${now.millisecond.toString().padLeft(3, '0')}.${file.extension}";

        final key =
            "Publicaciones/$formattedDateTime"; // Reemplaza con la ruta deseada en S3
        const options =
            StorageUploadFileOptions(accessLevel: StorageAccessLevel.guest);

        AWSFile awsFile;

        if (io.Platform.isAndroid || io.Platform.isIOS) {
          awsFile = AWSFile.fromPath(file.path!);
        } else {
          awsFile = AWSFile.fromData(Uint8List.fromList(file.bytes!));
        }
        final result = await Amplify.Storage.uploadFile(
          localFile: awsFile,
          key: key,
          options: options,
        );
        aUrlImagenes.add(dotenv.env['URLBASE_BUCKETS3']! + formattedDateTime);
      }
      print(aUrlImagenes);
    } catch (e) {
      print("Error al subir archivos a S3: $e");
    }
    return aUrlImagenes;
  }
}
