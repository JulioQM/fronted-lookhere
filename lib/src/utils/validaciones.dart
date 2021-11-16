class Validaciones {
  validarEmail(String correo) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);

    return regExp.hasMatch(correo ?? '')
        ? null
        : 'No valor ingresado no luce como un correo valido';
  }
}

final validaciones = new Validaciones();
