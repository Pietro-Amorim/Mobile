import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/registro_ponto.dart';

class PontoController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registrarPonto(RegistroPonto registro) async {
    await _firestore.collection('registros_ponto').add(registro.toMap());
  }

  Stream<QuerySnapshot> listarPontos(String usuarioId) {
    return _firestore
        .collection('registros_ponto')
        .where('usuarioId', isEqualTo: usuarioId)
        .orderBy('dataHora', descending: true)
        .snapshots();
  }
}
