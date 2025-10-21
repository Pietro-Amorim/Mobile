import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

/// Controlador responsável por registrar e listar os pontos de geolocalização
/// do usuário no Firebase Firestore.
class PointController {
  // Instância singleton do Firestore (recomendado pela documentação do Firebase)
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Registra um novo ponto de presença no Firestore com:
  /// - ID do usuário
  /// - Coordenadas de latitude e longitude
  /// - Data e hora atual no formato ISO 8601
  ///
  /// Lança exceções se:
  /// - A permissão de localização for negada
  /// - Não houver conexão com a internet
  /// - O Firestore retornar um erro
  Future<void> registrarPonto(String userId) async {
    // Obtém a posição geográfica atual do dispositivo
    // ⚠️ Requer permissão de localização (gerenciada pelo Geolocator)
    final position = await Geolocator.getCurrentPosition();

    // Salva os dados no Firestore na coleção 'pontos'
    // O método `.add()` gera um ID único automaticamente
    await _db.collection('pontos').add({
      'userId': userId,
      'latitude': position.latitude,
      'longitude': position.longitude,
      'dataHora': DateTime.now().toIso8601String(), // formato compatível com ordenação
    });
  }

  /// Retorna um Stream de snapshots do Firestore com todos os pontos
  /// registrados por um determinado usuário, ordenados da mais recente
  /// para a mais antiga.
  ///
  /// Ideal para uso com StreamBuilder na UI (ex: HistoryView).
  Stream<QuerySnapshot> listarPontos(String userId) {
    return _db
        .collection('pontos')
        // Filtra apenas os documentos pertencentes ao usuário atual
        .where('userId', isEqualTo: userId)
        // Ordena por data/hora em ordem decrescente (mais recente primeiro)
        .orderBy('dataHora', descending: true)
        // Retorna um Stream que atualiza automaticamente se houver novos pontos
        .snapshots();
  }
}