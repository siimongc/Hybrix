// lib/screens/vehicles_content.dart

import 'package:flutter/material.dart';
import 'package:app_frontend/widgets/vehicle_empty_state.dart';
import 'package:app_frontend/widgets/vehicle_list_item.dart';
import 'package:app_frontend/screens/create_vehicle_form.dart';
import 'package:app_frontend/data/services/api_service.dart';

class VehiclesContent extends StatefulWidget {
  const VehiclesContent({Key? key}) : super(key: key);
  @override
  State<VehiclesContent> createState() => _VehiclesContentState();
}

class _VehiclesContentState extends State<VehiclesContent> {
  late Future<List<Map<String, dynamic>>> _futureVehicles;

  @override
  void initState() {
    super.initState();
    _loadVehicles();
  }

  void _loadVehicles() {
    _futureVehicles = ApiService.getUserVehicles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Vehículos'),
        backgroundColor: const Color(0xFF64A3A3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _futureVehicles,
          builder: (context, snap) {
            if (snap.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snap.hasError) {
              return Center(child: Text('Error: ${snap.error}'));
            }
            final vehicles = snap.data ?? [];
            if (vehicles.isEmpty) {
              return VehicleEmptyState(onAdd: _navigateToAdd);
            }
            return ListView.separated(
              itemCount: vehicles.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, i) {
                final v = vehicles[i];
                return VehicleListItem(
                  name: v['plate'] ?? 'Sin placa',
                  onTap: () {},
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAdd,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _navigateToAdd() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (_) => const CreateVehicleForm()),
    );
    if (result != null) {
      setState(_loadVehicles);
    }
  }
}
