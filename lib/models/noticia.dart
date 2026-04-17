class Noticia {
  final int? id;
  final String titulo;
  final String resumen;
  final String contenido;
  final String imagenUrl;
  final String fecha;

  Noticia({
    this.id,
    required this.titulo,
    required this.resumen,
    required this.contenido,
    required this.imagenUrl,
    required this.fecha,
  });

  factory Noticia.fromJson(Map<String, dynamic> json) {
    return Noticia(
      id: json['id'],
      titulo: json['titulo'] ?? '',
      resumen: json['resumen'] ?? '',
      contenido: json['contenido'] ?? '',
      imagenUrl: json['imagen_url'] ?? '',
      fecha: json['fecha'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'resumen': resumen,
      'contenido': contenido,
      'imagen_url': imagenUrl,
      'fecha': fecha,
    };
  }
}
