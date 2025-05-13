// lib/screens/simulation_screen.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Asegúrate de agregar en pubspec.yaml: google_maps_flutter: ^2.2.0
import 'package:http/http.dart' as http;

/// Modelo de simulación
typedef Simulation = _Simulation;

class _Simulation {
  final int id;
  final String date;
  final double distance;
  final String duration;
  final double avgSpeed;

  _Simulation({
    required this.id,
    required this.date,
    required this.distance,
    required this.duration,
    required this.avgSpeed,
  });

  factory _Simulation.fromJson(Map<String, dynamic> json) {
    return _Simulation(
      id: json['id'] as int,
      date: json['date'] as String,
      distance: (json['distance'] as num).toDouble(),
      duration: json['duration'] as String,
      avgSpeed: (json['avg_speed'] as num).toDouble(),
    );
  }
}

/// Modelo de dato de simulación
typedef DataSimulation = _DataSimulation;

class _DataSimulation {
  final int id;
  final int idSimulation;
  final double latitude;
  final double longitude;
  final String timestamp;

  _DataSimulation({
    required this.id,
    required this.idSimulation,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });

  factory _DataSimulation.fromJson(Map<String, dynamic> json) {
    return _DataSimulation(
      id: json['id'] as int,
      idSimulation: json['id_simulation'] as int,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      timestamp: json['timestamp'] as String,
    );
  }
}

/// Servicio interno para llamadas a Node.js
class ApiService {
  static const String _baseUrl = 'http://10.0.2.2:3000/api';

  static Future<List<_Simulation>> getSimulations() async {
    final uri = Uri.parse('$_baseUrl/simulations');
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      final List<dynamic> arr = jsonDecode(res.body);
      return arr.map((e) => _Simulation.fromJson(e)).toList();
    } else {
      throw Exception('Error al cargar simulaciones: ${res.body}');
    }
  }

  static Future<List<_DataSimulation>> getDataSimulation(int id) async {
    final uri = Uri.parse('$_baseUrl/simulations/$id/data');
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      final List<dynamic> arr = jsonDecode(res.body);
      return arr.map((e) => _DataSimulation.fromJson(e)).toList();
    } else {
      throw Exception('Error al cargar datos de simulación: ${res.body}');
    }
  }
}

/// Pantalla “SimulationScreen”
class SimulationScreen extends StatefulWidget {
  const SimulationScreen({Key? key}) : super(key: key);

  @override
  _SimulationScreenState createState() => _SimulationScreenState();
}

class _SimulationScreenState extends State<SimulationScreen> {
  late Future<List<_Simulation>> _futureSims;

  @override
  void initState() {
    super.initState();
    _futureSims = ApiService.getSimulations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis Recorridos')),
      body: FutureBuilder<List<_Simulation>>(
        future: _futureSims,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final sims = snapshot.data ?? [];
          if (sims.isEmpty) {
            return const Center(child: Text('No hay recorridos registrados.'));
          }
          return ListView.builder(
            itemCount: sims.length,
            itemBuilder: (context, index) {
              final sim = sims[index];
              return ListTile(
                leading: const Icon(Icons.map, color: Color(0xFF64A3A3)),
                title: Text('Recorrido #${sim.id}'),
                subtitle: Text('Fecha: ${sim.date}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RecorridoDetailScreen(simulation: sim),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

/// Pantalla de detalle de un recorrido
class RecorridoDetailScreen extends StatefulWidget {
  final _Simulation simulation;
  const RecorridoDetailScreen({Key? key, required this.simulation}) : super(key: key);

  @override
  _RecorridoDetailScreenState createState() => _RecorridoDetailScreenState();
}

class _RecorridoDetailScreenState extends State<RecorridoDetailScreen> {
  late GoogleMapController _mapController;
  Set<Polyline> _polylines = {};
  LatLng _start = const LatLng(0, 0);
  LatLng _end = const LatLng(0, 0);
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await ApiService.getDataSimulation(widget.simulation.id);
    final points = data.map((d) => LatLng(d.latitude, d.longitude)).toList();
    setState(() {
      _start = points.first;
      _end = points.last;
      _polylines = {
        Polyline(
          polylineId: PolylineId('ruta_${widget.simulation.id}'),
          points: points,
          color: Colors.teal,
          width: 5,
        ),
      };
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recorrido #${widget.simulation.id}')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  flex: 2,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(target: _start, zoom: 14),
                    polylines: _polylines,
                    markers: {
                      Marker(markerId: const MarkerId('start'), position: _start),
                      Marker(markerId: const MarkerId('end'), position: _end),
                    },
                    onMapCreated: (c) => _mapController = c,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _StatCard(label: 'Distancia', value: widget.simulation.distance.toStringAsFixed(2) + ' km'),
                        _StatCard(label: 'Duración', value: widget.simulation.duration),
                        _StatCard(label: 'Vel. Media', value: widget.simulation.avgSpeed.toStringAsFixed(1) + ' km/h'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

/// Tarjeta de estadística
class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(value),
          ],
        ),
      ),
    );
  }
}
