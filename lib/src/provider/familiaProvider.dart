import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/provider/ruta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FamiliaProvider extends ChangeNotifier {
  Familiar managerFamiliar = new Familiar();
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Future<RespuestaModel> registrarFamiliar() async {
    var url = Uri.https(path.rutaEndPoint, path.pathFamiliar);
    print(url);
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          "pers_id": "1",
          "famil_nombres": managerFamiliar.getFamilNombres,
          "famil_apellidos": managerFamiliar.getFamilApellidos,
          "famil_celular": managerFamiliar.getFamilCelular,
          "famil_convencional": managerFamiliar.getFamilConvencional,
          "famil_direccion": managerFamiliar.getFamilDireccion
        }));
    print(response.statusCode);
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
