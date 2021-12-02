import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/routes/ruta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginProvider extends ChangeNotifier {
  Usuario managerUsuario = new Usuario();
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  String email; // todo borar
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
    print('$managerUsuario.getUsuaAlias - $managerUsuario.getUsuaClave');
    return formKey.currentState?.validate() ?? false;
  }

  Future<RespuestaModel> autentiacion() async {
    var url = Uri.https(path.rutaEndPoint, path.pathAutenticacion);
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'usua_alias': managerUsuario.getUsuaAlias,
          'usua_clave': managerUsuario.getUsuaClave
        }));
    if (response.statusCode == 200) {
      return RespuestaModel(
        success: true,
        data: response.body,
        mensaje: json.decode(response.body)['message'],
      );
    } else
      return RespuestaModel(
        success: false,
        data: response.body,
        mensaje: json.decode(response.body)['message'],
      );
  }
}
