// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:app_frontend/widgets/base_screen.dart';
import 'package:app_frontend/widgets/primary_button.dart';
import 'package:app_frontend/widgets/feature_card.dart';
import 'vehicles_content.dart';
import 'profile_screen.dart';
import 'notifications_screen.dart';
import 'green_footprint_screen.dart';
import 'bike_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  void _selectTab(int index) => setState(() => _currentIndex = index);

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      _HomeContent(onNavigateVehicles: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const VehiclesContent()),
        );
      }),
      const ProfileScreen(),
      const NotificationsScreen(),
    ];

    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex != 0) {
          _selectTab(0);
          return false;
        }
        return true;
      },
      child: BaseScreen(
        currentIndex: _currentIndex,
        onTabTapped: _selectTab,
        child: pages[_currentIndex],
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  final VoidCallback onNavigateVehicles;
  const _HomeContent({required this.onNavigateVehicles, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F7FA),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          PrimaryButton(
            label: '+ AÑADIR VEHÍCULO',
            icon: Icons.motorcycle,
            onPressed: onNavigateVehicles,
          ),
          const SizedBox(height: 24),
          const Text(
            'No hay un dispositivo conectado...',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF212121)),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                FeatureCard(icon: Icons.map, label: 'Mis recorridos', onTap: () => Navigator.pushNamed(context, '/simulation')),
                FeatureCard(icon: Icons.location_on, label: 'Ubicación\nVehículo', onTap: () => Navigator.pushNamed(context, '/vehicle_location')),
                FeatureCard(icon: Icons.bar_chart, label: 'Estadísticas', onTap: () => Navigator.pushNamed(context, '/stats')),
                FeatureCard(
                  icon: Icons.motorcycle,
                  label: 'Sobre mi\nmoto',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BikeDetailsScreen(
                        model: 'Yamaha MT-03',
                        techInspectionDate: DateTime(2025, 8, 15),
                        soatExpiryDate: DateTime(2025, 12, 31),
                        serviceDueDate: DateTime(2025, 6, 1),
                        insuranceProvider: 'Seguros Bogotá',
                      ),
                    ),
                  ),
                ),
                FeatureCard(icon: Icons.settings, label: 'Ajustes', onTap: () => Navigator.pushNamed(context, '/settings')),
                FeatureCard(
                  icon: Icons.eco,
                  label: 'Mi huella\nverde',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const GreenFootprintScreen(fuelSaved: 42.5, co2Saved: 90.0, distanceKm: 310.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
