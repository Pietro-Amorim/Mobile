import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PointController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registerPoint({required double latitude, required double longitude}) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Usuário não autenticado.');

    await _firestore.collection('pontos').add({
      'userId': user.uid,
      'timestamp': FieldValue.serverTimestamp(),
      'latitude': latitude,
      'longitude': longitude,
      'type': 'entrada', // ou dinâmico: entrada/saída
    });
  }
}