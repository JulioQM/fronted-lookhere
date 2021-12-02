import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/routes/ruta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FamiliaProvider extends ChangeNotifier {
  Familiar managerFamiliar = new Familiar();
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

  Future<RespuestaModel> registrarFamiliar() async {
    var url = Uri.https(path.rutaEndPoint, path.pathFamiliar);
    print(url);
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          "pers_id": managerFamiliar.getPersId,
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

  // consultar familiar
  Future<List<Familiar>> getListaFamiliar() async {
    var url = Uri.https(path.rutaEndPoint, path.pathFamiliar);
    print(url);
    var response = await http.get(url);
    Map<String, dynamic> user = jsonDecode(response.body);
    /*  print(user['familiar'][0]); */
    Map<String, dynamic> users = {'familiar': user['familiar'][0]};
    /* print('.......');
    var pr = {"familiar": users}; */
    List<Familiar> famil = [];
    users.forEach((key, value) {
      famil.add(Familiar.fromMap(value));
    });
    for (var p in famil) {
      print(p.familNombres);
      print(p.familApellidos);
    }
    return famil;
  }
}
