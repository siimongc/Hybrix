// lib/widgets/vehicle_empty_state.dart
import 'package:flutter/material.dart';
import 'primary_button.dart';

class VehicleEmptyState extends StatelessWidget {
  final VoidCallback onAdd;
  const VehicleEmptyState({required this.onAdd, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F7FA), // fondo claro
      width: double.infinity,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.directions_bike, size: 64, color: const Color(0xFF64A3A3)),
            const SizedBox(height: 16),
            Text(
              'Actualmente no tienes vehículos',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF212121), // texto gris oscuro
                decoration: TextDecoration.none,
              ),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Agregar vehículo',
              icon: Icons.add,
              onPressed: onAdd,
            ),
          ],
        ),
      ),
    );
  }
}