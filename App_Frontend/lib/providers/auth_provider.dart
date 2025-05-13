// lib/providers/auth_provider.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  String? _token;
  bool loading = false;
  String? error;

  String? get token => _token;

  AuthProvider() {
    _loadTokenFromStorage();
  }

  Future<void> _loadTokenFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('access_token');
    notifyListeners();
  }

  /// Retorna true si login OK, false si falla.
  Future<bool> login(String username, String password) async {
    loading = true;
    error = null;
    notifyListeners();

    final url = Uri.parse('http://10.0.2.2:3000/login');
    final resp = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'password': password}),
    );

    loading = false;
    if (resp.statusCode == 200) {
      final data = json.decode(resp.body);
      _token = data['access_token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', _token!);
      notifyListeners();
      return true;
    } else {
      final body = json.decode(resp.body);
      error = body['error'] ?? 'Error al iniciar sesión';
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    notifyListeners();
  }
}
