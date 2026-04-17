import 'package:flutter/material.dart';
import 'screens/splash/splash_screen.dart';

class AutoGestApp extends StatelessWidget {
  const AutoGestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AutoGest',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(),
    );
  }
}
