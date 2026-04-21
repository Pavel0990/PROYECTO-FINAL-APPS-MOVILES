import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/custom_textfield.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService _auth = AuthService();

  void login(BuildContext context) async {
    String? error = await _auth.login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    if (error != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTextField(controller: emailController, label: "Email"),
            SizedBox(height: 10),
            CustomTextField(
                controller: passwordController,
                label: "Password",
                isPassword: true),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => login(context),
              child: Text("Iniciar sesión"),
            ),

            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => RegisterScreen()));
              },
              child: Text("Crear cuenta"),
            ),

            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ForgotPasswordScreen()));
              },
              child: Text("¿Olvidaste tu contraseña?"),
            ),
          ],
        ),
      ),
    );
  }
}