import 'package:flutter/material.dart';

class BikeDetailsScreen extends StatelessWidget {
  // En la práctica estos datos vendrían de tu backend
  final String model;
  final DateTime techInspectionDate;
  final DateTime soatExpiryDate;
  final DateTime serviceDueDate;
  final String insuranceProvider;

  const BikeDetailsScreen({
    Key? key,
    required this.model,
    required this.techInspectionDate,
    required this.soatExpiryDate,
    required this.serviceDueDate,
    required this.insuranceProvider,
  }) : super(key: key);

  Widget _buildDetailCard(IconData icon, String title, String subtitle, Color color) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, size: 32, color: color),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }

  String _formatDate(DateTime d) => "${d.day.toString().padLeft(2,'0')}/"
      "${d.month.toString().padLeft(2,'0')}/${d.year}";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Sobre mi moto')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16, bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                model,
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            _buildDetailCard(
              Icons.build_circle,
              'Revisión Técnica',
              'Vence: ${_formatDate(techInspectionDate)}',
              Colors.blueAccent,
            ),
            _buildDetailCard(
              Icons.security,
              'SOAT',
              'Vence: ${_formatDate(soatExpiryDate)}\nProveedor: $insuranceProvider',
              Colors.green,
            ),
            _buildDetailCard(
              Icons.miscellaneous_services,
              'Próximo Servicio',
              'Fecha límite: ${_formatDate(serviceDueDate)}',
              Colors.orangeAccent,
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.edit),
                label: const Text('Editar datos'),
                onPressed: () {
                  // TODO: Navegar a pantalla de edición
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
