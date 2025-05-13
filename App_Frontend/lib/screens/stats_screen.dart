import 'package:flutter/material.dart';
import 'package:app_frontend/data/services/stats_service.dart';

class StatsScreen extends StatefulWidget {
  final int testId;
  const StatsScreen({Key? key, required this.testId}) : super(key: key);

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  Map<String, dynamic>? stats;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    try {
      final data = await StatsService.getLastStats(widget.testId);
      setState(() {
        stats = data;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error al cargar estadísticas: $e');
      setState(() => isLoading = false);
    }
  }

  Widget _buildStatCard({
    required String label,
    required IconData icon,
    required double value,
    required double max,
    required Color color,
    required String unit,
  }) {
    final percent = (value / max).clamp(0.0, 1.0);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    value: percent,
                    strokeWidth: 8,
                    color: color,
                    backgroundColor: color.withOpacity(0.2),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      value.toStringAsFixed(0),
                      style: TextStyle(
                        fontSize: 20,
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(unit, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Estadísticas')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : stats == null
              ? const Center(child: Text("No se encontraron datos"))
              : GridView.count(
                  padding: const EdgeInsets.all(16),
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
                  children: [
                    _buildStatCard(
                      label: "Velocidad",
                      icon: Icons.speed,
                      value: (stats!['speed'] as num).toDouble(),
                      max: 200, // ajusta según tu rango
                      color: theme.colorScheme.primary,
                      unit: "km/h",
                    ),
                    _buildStatCard(
                      label: "RPM",
                      icon: Icons.settings,
                      value: (stats!['rpm'] as num).toDouble(),
                      max: 10000,
                      color: Colors.redAccent,
                      unit: "rpm",
                    ),
                    _buildStatCard(
                      label: "Temperatura",
                      icon: Icons.thermostat,
                      value: (stats!['temperature'] as num).toDouble(),
                      max: 120,
                      color: Colors.orangeAccent,
                      unit: "°C",
                    ),
                    _buildStatCard(
                      label: "Voltaje",
                      icon: Icons.battery_charging_full,
                      value: (stats!['battery'] as num).toDouble(),
                      max: 100,
                      color: Colors.green,
                      unit: "V",
                    ),
                  ],
                ),
    );
  }
}
