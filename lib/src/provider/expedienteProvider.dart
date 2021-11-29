import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/routes/ruta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// expediente se refiere al historial clinico de enfermedades
class ExpedienteProvider extends ChangeNotifier {
  Expediente managerExpediente = new Expediente();
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

  Future<RespuestaModel> registrarExpediente() async {
    var url = Uri.https(path.rutaEndPoint, path.pathFamiliar);
    print(url);
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          {
            "pers_id": "1",
            "enfer_nombre": managerExpediente.getEnferNombre,
            "enfer_desc_medicacion": managerExpediente.getEnferDescMedicacion,
            "enfer_desc_dosificacion":
                managerExpediente.getEnferDescDosificacion,
            "enfer_desc_enfermedad": managerExpediente.getEnferDescEnfermedad
          }
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
