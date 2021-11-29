class Validaciones {
  validarEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);

    return regExp.hasMatch(value ?? '')
        ? null
        : 'El valor ingresado no luce como un correo valido';
  }

  validarClave({String clave, String claveRepetida}) {
    String mensaje = '';
    if (clave == claveRepetida) {
      return null;
    } else {
      mensaje = "No coinciden las claves!";
    }
    return mensaje;
  }
}

final validaciones = new Validaciones();
