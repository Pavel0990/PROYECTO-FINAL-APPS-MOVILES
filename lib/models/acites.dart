class AceiteModel {
  final int? id;
  final String nombre;
  final String tipo;

  AceiteModel ({
    this.id,
    required this.nombre,
    required this.tipo,
  });

  factory AceiteModel.fromJson(Map<String, dynamic> json) {
    return AceiteModel(
      id: json['id'],
      nombre: json['nombre'] ?? '',
      tipo: json['tipo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': nombre,
      'imagen': tipo,
    };
  }
}