// provider= proveedores de información,o tambien sirve como  gestor de estado

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/provider/ruta.dart';
import 'package:http/http.dart' as http;

class LoginFormProvider extends ChangeNotifier {
  // ChangeNotifier permite esa clase permite estar el paquetes de los provider
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  String email = '';
  String password = '';

  // simulacion de tiempo de espera backend
  bool _isLoading = false;
  // vamos a crear get y set
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    print(formKey.currentState?.validate());
    print('$email - $password');
    return formKey.currentState?.validate() ?? false;
  }

  Future<bool> autenticacion() async {
    print('$email ----entrando---- $password');
    var url = Uri.https(path.rutaEndPoint, path.pathAutenticacion);
    print(url);
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({"usua_alias": email, "usua_clave": password}));
    if (response.statusCode == 200) {
      return true;
    } else
      return false;
    /* print(response.statusCode);
    print(response.body); */
  }

  /* Future<List<Usuario>> getProvincias() async {
    var url = Uri.https(_baseURL, _path);
    final response = await http.get(url);
    // cogo los datos de la ruta
    var provincia = json.decode(response.body);
    // creo una lista de provincia
    List<Usuario> prov = [];
    // recorro mi areglo de provincias
    for (var p in provincia) {
      // esas provincias le agrego a mi mapa ,y itero
      prov.add(Usuario.fromMap(p));
    }
    // imprimo la lista de solo nombres de provincias
    for (var p in prov) {
      print(p.usuaAlias);
    }
    // Retorno mi lista de provincias
    return prov;
  } */
}
