// provider= proveedores de información,o tambien sirve como  gestor de estado
import 'package:flutter/cupertino.dart';

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
}
