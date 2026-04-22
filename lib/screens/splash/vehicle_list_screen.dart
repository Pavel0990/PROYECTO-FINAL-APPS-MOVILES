import 'package:flutter/material.dart';
import '../../auth/models/vehiculo.dart';
import '../../auth/services/vehicle_service.dart';

class VehicleListScreen extends StatefulWidget {
  const VehicleListScreen({super.key});
  @override
  State<VehicleListScreen> createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<VehicleListScreen> {
  List<Vehiculo> allVehicles = [];
  List<Vehiculo> filteredVehicles = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  _fetch() async {
    final list = await VehicleService().getVehicles();
    setState(() {
      allVehicles = list;
      filteredVehicles = list;
      loading = false;
    });
  }

  void _search(String query) {
    setState(() {
      filteredVehicles = allVehicles
          .where(
            (v) =>
                v.placa.toLowerCase().contains(query.toLowerCase()) ||
                v.marca.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mis Vehículos")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: "Buscar por placa o marca",
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _search,
            ),
          ),
          Expanded(
            child: loading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: filteredVehicles.length,
                    itemBuilder: (_, i) => ListTile(
                      title: Text(filteredVehicles[i].marca),
                      subtitle: Text(filteredVehicles[i].placa),
                      trailing: const Icon(Icons.edit),
                      onTap: () => Navigator.pushNamed(
                        context,
                        '/vehicle-form',
                        arguments: filteredVehicles[i],
                      ).then((_) => _fetch()),
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.pushNamed(context, '/vehicle-form').then((_) => _fetch()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
