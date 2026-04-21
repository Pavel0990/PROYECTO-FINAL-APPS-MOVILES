class MantenimientoModel {
  final int? id;
  final String titulo;
  final String descripcion;
  final String imagen;

  MantenimientoModel ({
    this.id,
    required this.titulo,
    required this.descripcion,
    required this.imagen,
  });

  factory MantenimientoModel.fromJson(Map<String, dynamic> json) {
    return MantenimientoModel(
      id: json['id'],
      titulo: json['titulo'] ?? '',
      descripcion: json['descripcion'] ?? '',
      imagen: json['imagen'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descripcion': descripcion,
      'imagen': imagen,
    };
  }
}
