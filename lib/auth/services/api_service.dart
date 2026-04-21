import 'dart:convert';
import 'package:dio/dio.dart';
import '../config/api_config.dart';
import 'auth_service.dart';

class ApiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  static Future<dynamic> get(String endpoint) async {
    final token = await AuthService.getToken();

    final response = await _dio.get(
      endpoint,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return response.data;
  }

  static Future<dynamic> post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    final token = await AuthService.getToken();

    final response = await _dio.post(
      endpoint,
      data: FormData.fromMap({'datax': jsonEncode(data)}),
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return response.data;
  }

  static Future<bool> testConnection() async {
    try {
      final response = await _dio.get('/');
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
