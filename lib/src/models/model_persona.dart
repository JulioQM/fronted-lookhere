class Persona {
  String usuaId;
  String persIdentificacion;
  String persNombres;
  String persApellidos;
  String persCelular;
  String persFechaNacimiento;
  String persSexo;
  String provId;
  String ciudId;
  String persDireccion;
  String enferId;
  String persDescMedicacion;
  String persDescDosificacion;
  String persDescEnfermedad;
  String persLinkQr;
  String persFoto;

  Persona({
    this.usuaId,
    this.persIdentificacion,
    this.persNombres,
    this.persApellidos,
    this.persCelular,
    this.persFechaNacimiento,
    this.persSexo,
    this.provId,
    this.ciudId,
    this.persDireccion,
    this.enferId,
    this.persDescMedicacion,
    this.persDescDosificacion,
    this.persDescEnfermedad,
    this.persLinkQr,
    this.persFoto,
  });

// getter and setter
  get getUsuaId => this.usuaId;
  set setUsuaId(String usuaId) => this.usuaId = usuaId;

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

  get getEnferId => this.enferId;
  set setEnferId(enferId) => this.enferId = enferId;

  get getPersDescMedicacion => this.persDescMedicacion;
  set setPersDescMedicacion(persDescMedicacion) =>
      this.persDescMedicacion = persDescMedicacion;

  get getPersDescDosificacion => this.persDescDosificacion;
  set setPersDescDosificacion(persDescDosificacion) =>
      this.persDescDosificacion = persDescDosificacion;

  get getPersDescEnfermedad => this.persDescEnfermedad;
  set setPersDescEnfermedad(persDescEnfermedad) =>
      this.persDescEnfermedad = persDescEnfermedad;

  get getPersLinkQr => this.persLinkQr;
  set setPersLinkQr(persLinkQr) => this.persLinkQr = persLinkQr;

  get getPersFoto => this.persFoto;
  set setPersFoto(persFoto) => this.persFoto = persFoto;
}
