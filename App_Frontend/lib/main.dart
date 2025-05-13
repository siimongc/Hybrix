// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_frontend/providers/auth_provider.dart';
import 'package:app_frontend/screens/login_screen.dart';
import 'package:app_frontend/screens/home_screen.dart';
import 'package:app_frontend/screens/profile_screen.dart';
import 'package:app_frontend/screens/notifications_screen.dart';
import 'package:app_frontend/screens/create_vehicle_form.dart';
import 'package:app_frontend/screens/simulation_screen.dart';
import 'package:app_frontend/screens/stats_screen.dart';
import 'package:app_frontend/screens/settings_screen.dart';
import 'package:app_frontend/screens/vehicles_content.dart';
import 'package:app_frontend/screens/green_footprint_screen.dart';
import 'package:app_frontend/screens/bike_details_screen.dart';
import 'package:app_frontend/screens/vehicle_location_screen.dart';



void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (_) => const LoginScreen(),
        '/home': (_) => const HomeScreen(),
        '/profile': (_) => const ProfileScreen(),
        '/notifications': (_) => const NotificationsScreen(),
        '/create': (_) => CreateVehicleForm(),
        '/simulation': (_) => const SimulationScreen(),
        '/stats': (_) => const StatsScreen(testId: 1),
        '/settings': (context) => const SettingsScreen(),
        '/vehicles': (_) => const VehiclesContent(),
        '/vehicle_location': (context) => const VehicleLocationScreen(),
      },
    );
  }
}