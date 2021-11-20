class Ciudad {
  int ciudId;
  int provId;
  String ciudNombre;
  DateTime ciudFechaRegistro;
  dynamic ciudFechaActualizacion;
  String ciudEstado;

  Ciudad({
    this.ciudId,
    this.provId,
    this.ciudNombre,
    this.ciudFechaRegistro,
    this.ciudFechaActualizacion,
    this.ciudEstado,
  });

  factory Ciudad.fromMap(Map<String, dynamic> json) => Ciudad(
        ciudId: json["ciud_id"],
        provId: json["prov_id"],
        ciudNombre: json["ciud_nombre"],
        ciudFechaRegistro: DateTime.parse(json["ciud_fecha_registro"]),
        ciudFechaActualizacion: json["ciud_fecha_actualizacion"],
        ciudEstado: json["ciud_estado"],
      );
// get and set
  get getCiudId => this.ciudId;
  set setCiudId(ciudId) => this.ciudId = ciudId;

  get getProvId => this.provId;
  set setProvId(provId) => this.provId = provId;

  get getCiudNombre => this.ciudNombre;
  set setCiudNombre(ciudNombre) => this.ciudNombre = ciudNombre;
}
