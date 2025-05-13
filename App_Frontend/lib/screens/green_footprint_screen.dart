// lib/screens/green_footprint_screen.dart

import 'package:flutter/material.dart';

class GreenFootprintScreen extends StatelessWidget {
  final double fuelSaved;
  final double co2Saved;
  final double distanceKm;

  const GreenFootprintScreen({
    Key? key,
    required this.fuelSaved,
    required this.co2Saved,
    required this.distanceKm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Huella Verde'),
        backgroundColor: Colors.green[700],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        color: const Color(0xFFF0F8F5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tu contribución al planeta:',
                style: theme.textTheme.headlineSmall),
            const SizedBox(height: 20),
            _buildStatCard('Combustible Ahorrado', '$fuelSaved litros', Icons.local_gas_station),
            const SizedBox(height: 12),
            _buildStatCard('CO₂ no emitido', '$co2Saved kg', Icons.cloud_outlined),
            const SizedBox(height: 12),
            _buildStatCard('Distancia en modo eco', '$distanceKm km', Icons.route),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.green[100],
      child: ListTile(
        leading: Icon(icon, color: Colors.green[800], size: 32),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
