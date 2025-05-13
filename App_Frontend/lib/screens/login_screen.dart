// lib/screens/login_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_frontend/providers/auth_provider.dart';
import 'package:app_frontend/widgets/input_field.dart';
import 'package:app_frontend/widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1B1B1C),
              Color(0xFF2E2E2F),
              Color(0xFF3A3A3B),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 300,
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 40),
                  CustomInputField(
                    controller: _emailController,
                    hint: 'Correo Electrónico',
                    icon: Icons.email_outlined,
                  ),
                  const SizedBox(height: 20),
                  CustomInputField(
                    controller: _passwordController,
                    hint: 'Contraseña',
                    icon: Icons.lock_outline,
                    obscureText: true,
                  ),
                  const SizedBox(height: 30),
                  PrimaryButton(
                    label: 'Entrar',
                    isLoading: auth.loading,
                    onPressed: () async {
                      final success = await auth.login(
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                      );
                      if (success) {
                        Navigator.pushReplacementNamed(context, '/home');
                      }
                    },
                  ),
                  if (auth.error != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      auth.error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
