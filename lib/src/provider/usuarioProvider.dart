import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/provider/ruta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UsuarioProvider extends ChangeNotifier {
  Usuario managerUsuario = new Usuario();
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  Future<RespuestaModel> registrarUsuario() async {
    var url = Uri.https(path.rutaEndPoint, path.pathUsuario);
    print(url);
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'rol_id': '2',
          'usua_alias': managerUsuario.getUsuaAlias,
          'usua_clave': managerUsuario.getUsuaClave,
          'usua_email': managerUsuario.getUsuaEmail
        }));
    print(response.statusCode);

    /*   
    print(response.body); */

    if (response.statusCode == 200) {
      return RespuestaModel(
        success: true,
        data: response.body,
        mensaje: json.decode(response.body)['msg'],
      );
    } else
      return RespuestaModel(
        success: false,
        data: response.body,
        mensaje: json.decode(response.body)['msg'],
      );
  }
}