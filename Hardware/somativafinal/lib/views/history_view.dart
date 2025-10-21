import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../controllers/auth_controller.dart';
import '../controllers/point_controller.dart';

/// Exibe o histórico de pontos registrados pelo usuário.
/// Usa StreamBuilder para atualização em tempo real do Firestore.
class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthController();
    final pointController = PointController();
    final user = auth.currentUser!; // só acessado após login garantido

    return Scaffold(
      appBar: AppBar(title: const Text('Histórico de Pontos')),
      body: StreamBuilder<QuerySnapshot>(
        // Escuta mudanças em tempo real na coleção 'pontos' do usuário
        stream: pointController.listarPontos(user.uid),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;
          if (docs.isEmpty) {
            return const Center(child: Text('Nenhum ponto registrado ainda.'));
          }

          // Lista os registros em ordem decrescente (mais recente primeiro)
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final dateTime = DateTime.parse(data['dataHora']);
              final formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(dateTime);

              return ListTile(
                leading: const Icon(Icons.access_time, color: Color(0xFF4A6B3F)),
                title: Text(formattedDate),
                subtitle: Text('Lat: ${data['latitude']}\nLng: ${data['longitude']}'),
              );
            },
          );
        },
      ),
    );
  }
}