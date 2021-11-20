class Enfermedad {
  int enferId;
  String enferNombre;
  DateTime enferFechaRegistro;
  dynamic enferFechaActualizacion;
  String enferEstado;

  Enfermedad({
    this.enferId,
    this.enferNombre,
    this.enferFechaRegistro,
    this.enferFechaActualizacion,
    this.enferEstado,
  });

  factory Enfermedad.fromMap(Map<String, dynamic> json) => Enfermedad(
        enferId: json["enfer_id"],
        enferNombre: json["enfer_nombre"],
        enferFechaRegistro: DateTime.parse(json["enfer_fecha_registro"]),
        enferFechaActualizacion: json["enfer_fecha_actualizacion"],
        enferEstado: json["enfer_estado"],
      );

// get y set
  get getEnferId => this.enferId;
  set setEnferId(enferId) => this.enferId = enferId;

  get getEnferNombre => this.enferNombre;
  set setEnferNombre(enferNombre) => this.enferNombre = enferNombre;
}
