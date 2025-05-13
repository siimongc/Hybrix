// lib/data/services/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants.dart';

class AuthService {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$API_BASE_URL/auth/login'); // nota las comillas dobles y $ correcto
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error ${response.statusCode}: ${response.body}');
    }
  }
}
