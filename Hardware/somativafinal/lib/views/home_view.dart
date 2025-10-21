import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../controllers/point_controller.dart';
import 'history_view.dart';

/// Tela principal após login.
/// Permite registrar ponto e acessar o histórico.
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = AuthController();
    final pointController = PointController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bater Ponto'),
        actions: [
          // Botão de logout no canto superior direito
          IconButton(
            onPressed: () {
              authController.logout();
              Navigator.pop(context); // volta para LoginView
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () async {
            final user = authController.currentUser;
            if (user != null) {
              await pointController.registrarPonto(user.uid);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Ponto registrado com sucesso!')),
              );
            }
          },
          icon: const Icon(Icons.access_time),
          label: const Text('Registrar Ponto'),
        ),
      ),
      // Botão flutuante para acessar o histórico
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const HistoryView()),
          );
        },
        child: const Icon(Icons.history),
      ),
    );
  }
}