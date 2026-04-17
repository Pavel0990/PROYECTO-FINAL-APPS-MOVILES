class VideoModel {
  final int? id;
  final String titulo;
  final String descripcion;
  final String youtubeUrl;
  final String thumbnail;

  VideoModel({
    this.id,
    required this.titulo,
    required this.descripcion,
    required this.youtubeUrl,
    required this.thumbnail,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'],
      titulo: json['titulo'] ?? '',
      descripcion: json['descripcion'] ?? '',
      youtubeUrl: json['youtube_url'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descripcion': descripcion,
      'youtube_url': youtubeUrl,
      'thumbnail': thumbnail,
    };
  }
}
