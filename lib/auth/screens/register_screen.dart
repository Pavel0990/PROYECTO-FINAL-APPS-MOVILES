    import 'package:flutter/material.dart';
    import '../services/auth_service.dart';
    import '../widgets/custom_textfield.dart';

    class RegisterScreen extends StatelessWidget {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final AuthService _auth = AuthService();

    void register(BuildContext context) async {
        if (passwordController.text.length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("La contraseña debe tener mínimo 6 caracteres")));
        return;
        }

        String? error = await _auth.register(
        emailController.text.trim(),
        passwordController.text.trim(),
        );

        if (error != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error)));
        } else {
        Navigator.pop(context);
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
        appBar: AppBar(title: Text("Registro")),
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
                onPressed: () => register(context),
                child: Text("Registrarse"),
                ),
            ],
            ),
        ),
        );
    }
    }