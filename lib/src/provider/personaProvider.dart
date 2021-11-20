import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/pages/exportPages.dart';
import 'package:fronted_lookhere/src/provider/ruta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PersonaProvider extends ChangeNotifier {
  Persona managerPersona = new Persona();
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  Future<RespuestaModel> registrarPersona() async {
    var url = Uri.https(path.rutaEndPoint, path.pathUsuario);
    print(url);
    print(idUsuario);
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          "usua_id": managerPersona.getUsuaId(),
          "pers_identificacion":
              managerPersona.getPersIdentificacion, //si existe
          "pers_nombres": managerPersona.getPersNombres, //si existe
          "pers_apellidos": managerPersona.getPersApellidos, //si existe
          "pers_celular": managerPersona.getPersCelular, //si existe
          "pers_fecha_nacimiento":
              managerPersona.getPersFechaNacimiento, //si existe
          "pers_sexo": managerPersona.getPersSexo, //si existe
          "prov_id": managerPersona.getProvId, //si existe
          "ciud_id": managerPersona.getCiudId, //si existe
          "pers_direccion": managerPersona.getPersDireccion, //si existe
          "enfer_id": managerPersona.getEnferId,
          "pers_desc_medicacion": managerPersona.getPersDescMedicacion,
          "pers_desc_dosificacion": managerPersona.getPersDescDosificacion,
          "pers_desc_enfermedad": managerPersona.getPersDescEnfermedad,
          "pers_link_qr": managerPersona.getPersLinkQr,
          "pers_foto": managerPersona.getPersFoto
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
