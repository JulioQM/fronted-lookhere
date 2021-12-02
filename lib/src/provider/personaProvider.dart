import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/routes/ruta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PersonaProvider extends ChangeNotifier {
  Persona managerPersona = new Persona();
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    print(formKey.currentState?.validate());
    return formKey.currentState?.validate() ?? false;
  }

  Future<RespuestaModel> registrarPersona() async {
    var url = Uri.https(path.rutaEndPoint, path.pathPersona);
    print(url);
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          "usua_id": managerPersona.getUsuaId,
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
          /*  "pers_link_qr": managerPersona.getPersLinkQr,
          "pers_foto": managerPersona.getPersFoto */
        }));
    print('..........');
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
        mensaje: json.decode(response.body)['message'],
      );
  }

  Future<RespuestaModel> obtenerEntidad() async {
    var url = Uri.https(path.rutaEndPoint, path.pathPersonaValidador);
    print(url);
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          /* "usua_id": '1', */
          "pers_identificacion":
              managerPersona.getPersIdentificacion, //si existe
          "pers_nombres": managerPersona.getPersNombres, //si existe
          "pers_apellidos": managerPersona.getPersApellidos, //si existe
          "pers_celular": managerPersona.getPersCelular,
          "pers_sexo": managerPersona.getPersSexo,
          "pers_fecha_nacimiento": managerPersona.getPersFechaNacimiento
        }));
    print('..........');
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
        mensaje: json.decode(response.body)['errors'][0]['msg'],
      );
  }

  /// Visualizacion de perfil al momento de registrarse
  // metodo que extrae mis datos
  Future<List<Persona>> getListaPersona(int busqueda) async {
    var url =
        Uri.https(path.rutaEndPoint, path.pathPerfilJoin + busqueda.toString());
    print(url);
    var response = await http.get(url);
    Map<String, dynamic> user = jsonDecode(response.body);
    print(user);
    List<Persona> pers = [];
    user.forEach((key, value) {
      pers.add(Persona.fromMap(value));
    });
    /* for (var p in pers) {
      print(p.persNombres);
      print(p.ciudNombre);
    } */
    return pers;
  }

  /// Visualizacion de home al momento de iniciar sesion
  // metodo que extrae mis datos
  Future<List<Persona>> getHomePersona(int busqueda) async {
    var url =
        Uri.https(path.rutaEndPoint, path.pathHomeJoin + busqueda.toString());
    print(url);
    var response = await http.get(url);
    Map<String, dynamic> user = jsonDecode(response.body);
    print(user);
    List<Persona> pers = [];
    user.forEach((key, value) {
      pers.add(Persona.fromMap(value));
    });

    return pers;
  }

  Future<RespuestaModel> actualizar() async {
    var url = Uri.https(path.rutaEndPoint, path.pathPersona + 2.toString());
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          /* "pers_nombres": managerPersona.getPersNombres, //si existe
          "pers_apellidos": managerPersona.getPersApellidos, */
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
