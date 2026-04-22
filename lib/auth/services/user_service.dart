import 'package:dio/dio.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  final _dio = Dio(BaseOptions(baseUrl: 'https://taller-itla.ia3x.com/api'));

  Future<Map<String, String>> getProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'nombre': prefs.getString('user_nombre') ?? 'Usuario ITLA',
      'correo': prefs.getString('user_correo') ?? 'estudiante@itla.edu.do',
      'foto': prefs.getString('user_foto') ?? '',
    };
  }

  Future<void> updateProfilePhoto(File image) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? "token_provisional_persona5";
    final formData = FormData.fromMap({
      'foto': await MultipartFile.fromFile(image.path, filename: 'perfil.jpg'),
    });
    await _dio.post(
      '/perfil/foto',
      data: formData,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}
