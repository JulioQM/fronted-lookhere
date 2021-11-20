import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/provider/ruta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// clase provider
class EnfermedadProvider extends ChangeNotifier {
  // metodo que extrae mis datos
  Future<List<Enfermedad>> getListaEnfermedad() async {
    var url = Uri.https(path.rutaEndPoint, path.pathEnfermedad);
    final response = await http.get(url);
    // cogo los datos de la ruta
    var enfermedad = json.decode(response.body);
    // creo una lista de provincia
    List<Enfermedad> enfer = [];
    // recorro mi areglo de provincias
    for (var e in enfermedad) {
      // esas provincias le agrego a mi mapa ,y itero
      enfer.add(Enfermedad.fromMap(e));
    }
    // imprimo la lista de solo nombres de provincias
    for (var e in enfer) {
      print(e.enferNombre);
    }
    // Retorno mi lista de provincias
    return enfer;
  }
}
