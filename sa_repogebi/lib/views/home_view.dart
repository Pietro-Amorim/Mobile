import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import 'register_point_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RepogeBi'),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthController().logout();
              Navigator.pushReplacementNamed(context, '/');
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Bem-vindo!'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterPointView()),
                );
              },
              child: const Text('Registrar Ponto'),
            ),
          ],
        ),
      ),
    );
  }
}