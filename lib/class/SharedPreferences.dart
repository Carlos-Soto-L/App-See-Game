import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesClass {
  static void writeData(String skey, dynamic dValue, String sTipoDato) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (sTipoDato == "String") {
        prefs.setString(skey, dValue);
      } else if (sTipoDato == "int") {
        prefs.setInt(skey, dValue);
      } else if (sTipoDato == "bool") {
        prefs.setBool(skey, dValue);
      } else if (sTipoDato == "Double") {
        prefs.setDouble(skey, dValue);
      } else if (sTipoDato == "ListString") {
        prefs.setStringList(skey, dValue);
      } else {
        throw Exception("Tipo de dato desconocido");
      }
    } catch (e) {
      print('Error al escribir datos: $e');
    }
  }

  static Future<dynamic> readData(String skey, String sTipoDato) async {
    dynamic dValor = null;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (sTipoDato == "String") {
        dValor = prefs.getString(skey);
      } else if (sTipoDato == "int") {
        dValor = prefs.getInt(skey);
      } else if (sTipoDato == "bool") {
        dValor = prefs.getBool(skey);
      } else if (sTipoDato == "Double") {
        dValor = prefs.getDouble(skey);
      } else if (sTipoDato == "ListString") {
        dValor = prefs.getStringList(skey);
      } else {
        throw Exception("Tipo de dato desconocido");
      }
    } catch (e) {
      throw Exception();
    }
    return dValor;
  }

  static void removeData(String skey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Remove data for the 'counter' key.
    await prefs.remove(skey);
  }
}
