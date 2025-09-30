import 'package:cine_favorite/views/register_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  //atributos
  final _emailField = TextEditingController();
  final _senhaField = TextEditingController();
  final _authController = FirebaseAuth.instance;
  bool _senhaOculta = true;

  //método
  void _login() async {
    try {
      await _authController.signInWithEmailAndPassword(
        email: _emailField.text.trim(),
        password: _senhaField.text,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Falha ao Fazer Login $e"))
      );
    }
  }

  //build da Tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Card(
            elevation: 8,
            shadowColor: Colors.black.withOpacity(0.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _emailField,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _senhaField,
                    decoration: InputDecoration(
                      labelText: "Senha",
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () => setState(() {
                          _senhaOculta = !_senhaOculta;
                        }),
                        icon: _senhaOculta
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                    ),
                    obscureText: _senhaOculta,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        "Entrar",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterView()),
                    ),
                    child: const Text("Não tem uma conta? Registre-se"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}