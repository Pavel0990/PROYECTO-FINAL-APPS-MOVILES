class Vehiculo {
  final int? id;
  final String marca;
  final String modelo;
  final String ano;
  final String placa;
  final String color;

  Vehiculo({
    this.id,
    required this.marca,
    required this.modelo,
    required this.ano,
    required this.placa,
    required this.color,
  });

  factory Vehiculo.fromJson(Map<String, dynamic> json) {
    return Vehiculo(
      id: json['id'],
      marca: json['marca'] ?? '',
      modelo: json['modelo'] ?? '',
      ano: json['ano']?.toString() ?? '',
      placa: json['placa'] ?? '',
      color: json['color'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'marca': marca,
      'modelo': modelo,
      'ano': ano,
      'placa': placa,
      'color': color,
    };
  }
}
