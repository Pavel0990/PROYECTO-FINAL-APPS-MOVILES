import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/vehiculo.dart';

class VehicleService {
  final _dio = Dio(BaseOptions(baseUrl: 'https://taller-itla.ia3x.com/api'));

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<List<Vehiculo>> getVehicles() async {
    final token = await _getToken();
    try {
      final r = await _dio.get(
        '/vehiculos',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return (r.data as List).map((v) => Vehiculo.fromJson(v)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> saveVehicle(Vehiculo v, File? image) async {
    final token = await _getToken();
    final formData = FormData.fromMap({'datax': jsonEncode(v.toJson())});
    if (image != null) {
      formData.files.add(
        MapEntry(
          'foto',
          await MultipartFile.fromFile(image.path, filename: 'car.jpg'),
        ),
      );
    }
    await _dio.post(
      v.id == null ? '/vehiculos' : '/vehiculos/editar',
      data: formData,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}
