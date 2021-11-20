class Usuario {
  int usuaId;
  int rolId;
  String usuaAlias;
  String usuaClave;
  String usuaEmail;
  DateTime usuaFechaRegistro;
  dynamic usuaFechaActualizacion;
  String usuaEstado;

  Usuario({
    this.usuaId,
    this.rolId,
    this.usuaAlias,
    this.usuaClave,
    this.usuaEmail,
    this.usuaFechaRegistro,
    this.usuaFechaActualizacion,
    this.usuaEstado,
  });

  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        usuaId: json["usua_id"],
        rolId: json["rol_id"],
        usuaAlias: json["usua_alias"],
        usuaClave: json["usua_clave"],
        usuaEmail: json["usua_email"],
        usuaFechaRegistro: DateTime.parse(json["usua_fecha_registro"]),
        usuaFechaActualizacion: json["usua_fecha_actualizacion"],
        usuaEstado: json["usua_estado"],
      );
// accesores hay dos maneras
// get
  /*  String getUsuaAlias() {
    return this.usuaAlias;
  }

  String getUsuaClave() {
    return this.usuaClave;
  }

  String getUsuaEmail() {
    return this.usuaEmail;
  } */

  // set
  /* void setUsuaAlias(String usuaAlias) {
    this.usuaAlias = usuaAlias;
  }

  void setUsuaClave(String usuaClave) {
    this.usuaClave = usuaClave;
  }

  void setUsuaEmail(String usuaEmail) {
    this.usuaEmail = usuaEmail;
  } */

  // get
  int get getUsuaId {
    return this.usuaId;
  }

  String get getUsuaAlias {
    return this.usuaAlias;
  }

  String get getUsuaClave {
    return this.usuaClave;
  }

  String get getUsuaEmail {
    return this.usuaEmail;
  }

  // set
  set setUsuaId(int usuaId) {
    this.usuaId = usuaId;
  }

  set setUsuaAlias(String usuaAlias) {
    this.usuaAlias = usuaAlias;
  }

  set setUsuaClave(String usuaClave) {
    this.usuaClave = usuaClave;
  }

  set setUsuaEmail(String usuaEmail) {
    this.usuaEmail = usuaEmail;
  }
}
