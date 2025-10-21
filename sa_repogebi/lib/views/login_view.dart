import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _nifController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authController = AuthController();
  bool _isLoading = false;

  Future<void> _login() async {
    if (_nifController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha NIF e senha.')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await _authController.loginWithNif(_nifController.text.trim(), _passwordController.text);
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loginWithBiometrics() async {
    final user = await _authController.loginWithBiometrics();
    if (user != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Falha na autenticação biométrica.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro de Ponto')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nifController,
              decoration: const InputDecoration(labelText: 'NIF'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _login,
                    child: const Text('Entrar com NIF e Senha'),
                  ),
            const SizedBox(height: 20),
            FutureBuilder<bool>(
              future: _authController.isBiometricAvailable(),
              builder: (context, snapshot) {
                if (snapshot.data == true) {
                  return ElevatedButton.icon(
                    onPressed: _loginWithBiometrics,
                    icon: const Icon(Icons.fingerprint),
                    label: const Text('Entrar com Biometria'),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}