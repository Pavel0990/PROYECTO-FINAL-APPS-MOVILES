import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '/auth/services/user_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _service = UserService();
  Map<String, String> userData = {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  _load() async {
    final data = await _service.getProfileData();
    setState(() => userData = data);
  }

  _changePhoto(ImageSource source) async {
    final picked = await ImagePicker().pickImage(source: source);
    if (picked != null) {
      await _service.updateProfilePhoto(File(picked.path));
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Foto actualizada")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mi Perfil")),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const CircleAvatar(radius: 60, child: Icon(Icons.person, size: 60)),
            const SizedBox(height: 10),
            Text(
              userData['nombre'] ?? '',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(userData['correo'] ?? ''),
            const SizedBox(height: 40),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Cambiar foto (Cámara)"),
              onTap: () => _changePhoto(ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Cambiar foto (Galería)"),
              onTap: () => _changePhoto(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }
}
