import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StatsService {
  static const _baseUrl = 'http://10.0.2.2:3000';

  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  static Future<Map<String, dynamic>> getLastStats(int testId) async {
    final token = await _getToken();
    final uri = Uri.parse('$_baseUrl/hibrix/statsData/$testId');

    final res = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    if (res.statusCode == 200) {
      return Map<String, dynamic>.from(json.decode(res.body));
    } else {
      throw Exception('Error al cargar estadísticas: ${res.body}');
    }
  }
}
