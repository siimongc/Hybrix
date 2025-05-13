// lib/data/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String _baseUrl = 'http://10.0.2.2:3000';

  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  /// GET /hibrix/users/getUserVehicle
  static Future<List<Map<String, dynamic>>> getUserVehicles() async {
    final token = await _getToken();
    final uri = Uri.parse('$_baseUrl/hibrix/users/getUserVehicle');
    final res = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
    if (res.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(res.body));
    } else {
      throw Exception('Error al cargar vehículos: ${res.body}');
    }
  }

  /// POST /hibrix/vehicle/create
  /// Recibe en payload todos los campos, incluyendo id_user e id_type
  static Future<Map<String, dynamic>> createVehicle(
      Map<String, dynamic> payload) async {
    final token = await _getToken();
    final uri = Uri.parse('$_baseUrl/hibrix/vehicle/create');
    final res = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: json.encode(payload),
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      return json.decode(res.body) as Map<String, dynamic>;
    } else {
      throw Exception('Error al registrar vehículo: ${res.body}');
    }
  }
}
