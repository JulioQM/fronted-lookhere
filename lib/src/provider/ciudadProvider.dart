import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/provider/ruta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CiudadProvider extends ChangeNotifier {
  Ciudad manageRCiudad = new Ciudad();
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  // metodo que extrae mis datos
  Future<List<Ciudad>> getListaCiudades(String busqueda) async {
    // String busqueda = '10';
    var url = Uri.https(path.rutaEndPoint, path.pathCiudad + busqueda);
    var response = await http.get(url);
    // cogo los datos de la ruta
    var ciudad = json.decode(response.body);
    // creo una lista de provincia
    List<Ciudad> ciud = [];
    // recorro mi areglo de provincias
    for (var c in ciudad) {
      // esas provincias le agrego a mi mapa ,y itero
      ciud.add(Ciudad.fromMap(c));
    }
    // imprimo la lista de solo nombres de provincias
    for (var c in ciud) {
      print(c.ciudNombre);
    }
    // Retorno mi lista de provincias
    return ciud;
  }
}
