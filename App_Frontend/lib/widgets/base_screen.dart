import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;
  final int currentIndex;
  final ValueChanged<int>? onTabTapped;

  const BaseScreen({
    required this.child,
    this.currentIndex = 0,
    this.onTabTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF64A3A3),
        elevation: 4,
        centerTitle: true,
        title: SizedBox(
        height: kToolbarHeight * 3,
        child: Image.asset(
          'assets/images/logo_blanco1.png',
          fit: BoxFit.contain,
        ),
      ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              if (value == 'ajustes') {
                Navigator.pushNamed(context, '/settings');
              } else if (value == 'logout') {
                // Implementa tu lógica de logout
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'ajustes',
                child: Text('Ajustes'),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('Cerrar sesión'),
              ),
            ],
          ),
        ],
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTabTapped ?? (int index) {
          // Navegación básica entre pantallas
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/profile');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/notifications');
          }
        },
        selectedItemColor: const Color(0xFF64A3A3),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifs',
          ),
        ],
      ),
    );
  }
}
