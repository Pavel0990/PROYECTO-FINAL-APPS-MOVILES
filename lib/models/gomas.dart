class GomasModel {
  final int? id;
  final String estado;
  final String descripcion;

  GomasModel ({
    this.id,
    required this.estado,
    required this.descripcion,
  });

  factory GomasModel.fromJson(Map<String, dynamic> json) {
    return GomasModel(
      id: json['id'],
      estado: json['estado'] ?? '',
      descripcion: json['descripcion'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'estado': estado,
      'descripcion': descripcion,
    };
  }
}