class Provincia {
  int provId;
  String provNombre;
  DateTime provFechaRegistro;
  dynamic provFechaActualizacion;
  String provEstado;

  Provincia({
    this.provId,
    this.provNombre,
    this.provFechaRegistro,
    this.provFechaActualizacion,
    this.provEstado,
  });

  factory Provincia.fromMap(Map<String, dynamic> json) => Provincia(
        provId: json["prov_id"],
        provNombre: json["prov_nombre"],
        provFechaRegistro: DateTime.parse(json["prov_fecha_registro"]),
        provFechaActualizacion: json["prov_fecha_actualizacion"],
        provEstado: json["prov_estado"],
      );

// get y set
  get getProvId => this.provId;
  set setProvId(provId) => this.provId = provId;

  get getProvNombre => this.provNombre;
  set setProvNombre(String provNombre) => this.provNombre = provNombre;
}
