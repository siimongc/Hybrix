// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  Widget _buildOption({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, size: 28, color: Colors.blueGrey),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(description),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          _buildOption(
            icon: Icons.person,
            title: 'Perfil',
            description: 'Editar información de usuario',
            onTap: () => Navigator.pushNamed(context, '/profile'),
          ),
          _buildOption(
            icon: Icons.lock,
            title: 'Seguridad',
            description: 'Cambiar contraseña y PIN',
            onTap: () {/* TODO: Seguridad */},
          ),
          _buildOption(
            icon: Icons.notifications,
            title: 'Notificaciones',
            description: 'Configurar alertas y sonidos',
            onTap: () => Navigator.pushNamed(context, '/notifications'),
          ),
          _buildOption(
            icon: Icons.palette,
            title: 'Tema',
            description: 'Modo claro / oscuro',
            onTap: () {/* TODO: Tema */},
          ),
          _buildOption(
            icon: Icons.info,
            title: 'Acerca de',
            description: 'Versión de la aplicación y créditos',
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Tu App',
                applicationVersion: '1.0.0',
                children: const [Text('Desarrollado por Tu Nombre')],
              );
            },
          ),
        ],
      ),
    );
  }
}
