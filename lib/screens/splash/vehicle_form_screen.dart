import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../auth/models/vehiculo.dart';
import '../../auth/services/vehicle_service.dart';

class VehicleFormScreen extends StatefulWidget {
  final Vehiculo? vehiculo; // Si viene un vehículo, es para EDITAR
  const VehicleFormScreen({super.key, this.vehiculo});

  @override
  State<VehicleFormScreen> createState() => _VehicleFormScreenState();
}

class _VehicleFormScreenState extends State<VehicleFormScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  final _service = VehicleService();

  late TextEditingController _marcaCtrl;
  late TextEditingController _modeloCtrl;
  late TextEditingController _anioCtrl;
  late TextEditingController _placaCtrl;
  late TextEditingController _chasisCtrl;
  late TextEditingController _ruedasCtrl;

  @override
  void initState() {
    super.initState();
    _marcaCtrl = TextEditingController(text: widget.vehiculo?.marca ?? '');
    _modeloCtrl = TextEditingController(text: widget.vehiculo?.modelo ?? '');
    _anioCtrl = TextEditingController(text: widget.vehiculo?.anio ?? '');
    _placaCtrl = TextEditingController(text: widget.vehiculo?.placa ?? '');
    _chasisCtrl = TextEditingController(text: widget.vehiculo?.chasis ?? '');
    _ruedasCtrl = TextEditingController(text: widget.vehiculo?.ruedas ?? '4');
  }

  Future _takePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.vehiculo == null ? "Nuevo Vehículo" : "Editar Vehículo",
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Sección de Foto
            Center(
              child: GestureDetector(
                onTap: _takePhoto,
                child: Container(
                  height: 150,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: _image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.file(_image!, fit: BoxFit.cover),
                        )
                      : const Icon(
                          Icons.camera_alt,
                          size: 50,
                          color: Colors.grey,
                        ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Campos del Formulario
            TextFormField(
              controller: _marcaCtrl,
              decoration: const InputDecoration(labelText: "Marca"),
            ),
            TextFormField(
              controller: _modeloCtrl,
              decoration: const InputDecoration(labelText: "Modelo"),
            ),
            TextFormField(
              controller: _anioCtrl,
              decoration: const InputDecoration(labelText: "Año"),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _placaCtrl,
              decoration: const InputDecoration(labelText: "Placa"),
            ),
            TextFormField(
              controller: _chasisCtrl,
              decoration: const InputDecoration(labelText: "Chasis"),
            ),
            TextFormField(
              controller: _ruedasCtrl,
              decoration: const InputDecoration(
                labelText: "Cantidad de Ruedas",
              ),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 30),

            // Botón de Guardar
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: _save,
              child: const Text(
                "GUARDAR VEHÍCULO",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      final v = Vehiculo(
        id: widget.vehiculo?.id,
        marca: _marcaCtrl.text,
        modelo: _modeloCtrl.text,
        anio: _anioCtrl.text,
        placa: _placaCtrl.text,
        chasis: _chasisCtrl.text,
        ruedas: _ruedasCtrl.text,
      );

      try {
        await _service.saveVehicle(v, _image);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("¡Guardado con éxito!")));
          Navigator.pop(context); // Regresa a la lista
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error al guardar: $e")));
      }
    }
  }

  @override
  void dispose() {
    _marcaCtrl.dispose();
    _modeloCtrl.dispose();
    _anioCtrl.dispose();
    _placaCtrl.dispose();
    _chasisCtrl.dispose();
    _ruedasCtrl.dispose();
    super.dispose();
  }
}
