    import 'package:flutter/material.dart';
    import '../services/auth_service.dart';

    class ForgotPasswordScreen extends StatelessWidget {
    final emailController = TextEditingController();
    final AuthService _auth = AuthService();

    void reset(BuildContext context) async {
        String? error =
            await _auth.resetPassword(emailController.text.trim());

        if (error != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error)));
        } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Correo enviado")));
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
        appBar: AppBar(title: Text("Recuperar contraseña")),
        body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
            children: [
                TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                onPressed: () => reset(context),
                child: Text("Enviar"),
                ),
            ],
            ),
        ),
        );
    }
    }