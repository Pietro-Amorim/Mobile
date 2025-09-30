import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  //atributos
  final _emailField = TextEditingController();
  final _senhaField = TextEditingController();
  final _confSenhaField = TextEditingController();
  final _authController = FirebaseAuth.instance;
  bool _senhaOculta = true;
  bool _confSenhaOculta = true;

  //método _registrar
  void _registrar() async {
    if (_senhaField.text != _confSenhaField.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("As senhas não coincidem"))
      );
      return;
    }
    
    if (_senhaField.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("A senha deve ter pelo menos 6 caracteres"))
      );
      return;
    }

    try {
      await _authController.createUserWithEmailAndPassword(
        email: _emailField.text.trim(), 
        password: _senhaField.text
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Falha ao registrar: $e"))
      );
    }
  }

  //build da tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro")),
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
                    "Criar Conta",
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
                  const SizedBox(height: 16),
                  TextField(
                    controller: _confSenhaField,
                    decoration: InputDecoration(
                      labelText: "Confirmar Senha",
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        onPressed: () => setState(() {
                          _confSenhaOculta = !_confSenhaOculta;
                        }),
                        icon: _confSenhaOculta
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                    ),
                    obscureText: _confSenhaOculta,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _registrar,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        "Registrar",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Já tem uma conta? Faça login"),
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