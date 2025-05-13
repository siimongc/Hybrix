// lib/screens/notifications_screen.dart
import 'package:flutter/material.dart';
import 'package:app_frontend/widgets/notification_item.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de notificaciones de ejemplo
    final notifications = [
      {'title': 'Mantenimiento completado', 'subtitle': 'Tu moto fue revisada exitosamente.', 'time': '2h atrás'},
      {'title': 'Nueva ruta disponible', 'subtitle': 'Se ha añadido una ruta cerca de tu zona.', 'time': '1d atrás'},
      {'title': 'Recordatorio de seguro', 'subtitle': 'Vence en 3 días tu póliza.', 'time': '3d atrás'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones'),
        backgroundColor: const Color(0xFF64A3A3),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final notif = notifications[index];
          return NotificationItem(
            title: notif['title']!, 
            subtitle: notif['subtitle']!, 
            time: notif['time']!,
            onTap: () {
              // lógica para detalle o marcar como leído
            },
          );
        },
      ),
    );
  }
}
