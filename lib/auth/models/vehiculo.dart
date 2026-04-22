class Vehiculo {
  final String? id;
  final String placa, chasis, marca, modelo, anio, ruedas;
  final String? fotoUrl;

  Vehiculo({
    this.id,
    required this.placa,
    required this.chasis,
    required this.marca,
    required this.modelo,
    required this.anio,
    required this.ruedas,
    this.fotoUrl,
  });

  factory Vehiculo.fromJson(Map<String, dynamic> json) => Vehiculo(
    id: json['id']?.toString(),
    placa: json['placa']?.toString() ?? '',
    chasis: json['chasis']?.toString() ?? '',
    marca: json['marca']?.toString() ?? '',
    modelo: json['modelo']?.toString() ?? '',
    anio: json['anio']?.toString() ?? '',
    ruedas: json['cantidad_ruedas']?.toString() ?? '4',
    fotoUrl: json['foto_url'],
  );

  Map<String, dynamic> toJson() => {
    if (id != null) 'id': id,
    'placa': placa,
    'chasis': chasis,
    'marca': marca,
    'modelo': modelo,
    'anio': anio,
    'cantidad_ruedas': ruedas,
  };
}
