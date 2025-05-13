// lib/widgets/vehicle_list_item.dart
import 'package:flutter/material.dart';

class VehicleListItem extends StatelessWidget {
  final String name;
  final VoidCallback onTap;
  const VehicleListItem({required this.name, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.motorcycle, color: Color(0xFF64A3A3)),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF002F6C)),
      ),
      onTap: onTap,
    );
  }
}
