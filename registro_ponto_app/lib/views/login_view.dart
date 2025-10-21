import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import 'home_view.dart';

class LoginView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: senhaController, decoration: InputDecoration(labelText: 'Senha'), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final user = await authController.loginEmail(emailController.text, senhaController.text);
                if (user != null) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeView(usuarioId: user.uid)));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao logar')));
                }
              },
              child: Text('Login Email'),
            ),
            ElevatedButton(
              onPressed: () async {
                bool ok = await authController.loginBiometria();
                if (ok) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeView(usuarioId: 'biometriaUser')));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro biometria')));
                }
              },
              child: Text('Login Biometria'),
            ),
          ],
        ),
      ),
    );
  }
}
