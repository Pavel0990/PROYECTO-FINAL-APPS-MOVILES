import 'package:flutter/material.dart';
import 'screens/splash/vehicle_list_screen.dart';
import 'screens/splash/vehicle_form_screen.dart';
import 'screens/splash/profile_screen.dart';
import 'screens/splash/splash_screen.dart';

class AutoGestApp extends StatelessWidget {
  const AutoGestApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/vehicle-list': (context) => const VehicleListScreen(),
        '/vehicle-form': (context) => const VehicleFormScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
