import 'package:flutter/material.dart';
import '../controllers/ponto_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/registro_card.dart';

class HistoricoView extends StatelessWidget {
  final String usuarioId;
  final PontoController pontoController = PontoController();

  HistoricoView({required this.usuarioId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Histórico de Pontos')),
      body: StreamBuilder<QuerySnapshot>(
        stream: pontoController.listarPontos(usuarioId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          final registros = snapshot.data!.docs;
          if (registros.isEmpty) return Center(child: Text('Nenhum registro'));

          return ListView.builder(
            itemCount: registros.length,
            itemBuilder: (context, index) {
              final data = registros[index].data() as Map<String, dynamic>;
              return RegistroCard(
                dataHora: DateTime.parse(data['dataHora']),
                latitude: data['latitude'],
                longitude: data['longitude'],
              );
            },
          );
        },
      ),
    );
  }
}
