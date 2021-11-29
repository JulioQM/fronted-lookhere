class Persona {
  int persId; // estaba String
  int usuaId; // estaba String
  String persIdentificacion;
  String persNombres;
  String persApellidos;
  String persCelular;
  String persFechaNacimiento;
  String persDiaNacimiento; // agregado
  String persSexo;
  int provId; // estaba String
  int ciudId; // estaba String
  String provNombre; // agregado
  String ciudNombre; // agregado
  String persDireccion;
  String persLinkQr;
  String persFoto;

  Persona({
    this.persId,
    this.usuaId,
    this.persIdentificacion,
    this.persNombres,
    this.persApellidos,
    this.persCelular,
    this.persFechaNacimiento,
    this.persDiaNacimiento,
    this.persSexo,
    this.provId,
    this.provNombre, // agregado
    this.ciudId,
    this.ciudNombre, // agregado
    this.persDireccion,
    this.persLinkQr,
    this.persFoto,
  });

  factory Persona.fromMap(Map<String, dynamic> json) => Persona(
        persId: json["pers_id"],
        usuaId: json["usua_id"],
        persIdentificacion: json["pers_identificacion"],
        persNombres: json["pers_nombres"],
        persApellidos: json["pers_apellidos"],
        persCelular: json["pers_celular"],
        persFechaNacimiento: (json["pers_fecha_nacimiento"]),
        persDiaNacimiento: json["pers_dia_nacimiento"],
        persSexo: json["pers_sexo"],
        provId: json["prov_id"],
        ciudId: json["ciud_id"],
        provNombre: json["prov_nombre"],
        ciudNombre: json["ciud_nombre"],
        persDireccion: json["pers_direccion"],
        persLinkQr: json["pers_link_qr"],
        persFoto: json["pers_foto"],
      );

// getter and setter
  get getUsuaId => this.usuaId;
  set setUsuaId(usuaId) => this.usuaId = usuaId;

  get getPersIdentificacion => this.persIdentificacion;
  set setPersIdentificacion(persIdentificacion) =>
      this.persIdentificacion = persIdentificacion;

  get getPersNombres => this.persNombres;
  set setPersNombres(persNombres) => this.persNombres = persNombres;

  get getPersApellidos => this.persApellidos;
  set setPersApellidos(persApellidos) => this.persApellidos = persApellidos;

  get getPersCelular => this.persCelular;
  set setPersCelular(persCelular) => this.persCelular = persCelular;

  get getPersFechaNacimiento => this.persFechaNacimiento;

  set setPersFechaNacimiento(persFechaNacimiento) =>
      this.persFechaNacimiento = persFechaNacimiento;

  get getPersSexo => this.persSexo;
  set setPersSexo(persSexo) => this.persSexo = persSexo;

  get getProvId => this.provId;
  set setProvId(provId) => this.provId = provId;

  get getCiudId => this.ciudId;
  set setCiudId(ciudId) => this.ciudId = ciudId;

  get getPersDireccion => this.persDireccion;
  set setPersDireccion(persDireccion) => this.persDireccion = persDireccion;

  get getPersLinkQr => this.persLinkQr;
  set setPersLinkQr(persLinkQr) => this.persLinkQr = persLinkQr;

  get getPersFoto => this.persFoto;
  set setPersFoto(persFoto) => this.persFoto = persFoto;
}
