import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/base_screen.dart';
import 'package:provider/provider.dart';
import 'package:app_frontend/providers/auth_provider.dart';
import 'package:app_frontend/screens/home_screen.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  String? nextMaintenanceDate;
  bool isLoading = true;
  bool hasError = false;
  int motoId = 1; // ID fijo por ahora

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final int? id = ModalRoute.of(context)?.settings.arguments as int?;
    if (id != null) {
      motoId = id;
      fetchMaintenanceData(motoId);
    }
  }

  Future<void> fetchMaintenanceData(int id) async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:3000/hybrix/maintenanceData/$id'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          nextMaintenanceDate = data['date'];
          isLoading = false;
        });
      } else {
        throw Exception('Error al cargar los datos');
      }
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Mantenimiento Moto $motoId',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : hasError
                    ? const Text(
                        'Error al cargar los datos 😢',
                        style: TextStyle(fontSize: 18, color: Colors.red),
                      )
                    : Card(
                        margin: const EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Próximo Mantenimiento',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                nextMaintenanceDate ?? 'No disponible',
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
