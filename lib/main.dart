import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/services/auth_service.dart';
import 'auth/screens/login_screen.dart';
import 'home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: _auth.authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return LoginScreen();
          } else {
            return HomeScreen();
          }
        },
      ),
    );
  }
}