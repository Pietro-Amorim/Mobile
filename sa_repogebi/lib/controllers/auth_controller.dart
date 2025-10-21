import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import '../models/user_model.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final LocalAuthentication _localAuth = LocalAuthentication();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Login com NIF e senha
  Future<User?> loginWithNif(String nif, String password) async {
    try {
      final email = '$nif@empresa.com';
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Salva NIF para biometria futura
      await _storage.write(key: 'saved_nif', value: nif);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        throw Exception('NIF ou senha inválidos.');
      }
      throw Exception('Erro ao autenticar: ${e.message}');
    }
  }

  // Verifica se biometria pode ser usada
  Future<bool> isBiometricAvailable() async {
    try {
      return await _localAuth.canCheckBiometrics;
    } catch (_) {
      return false;
    }
  }

  // Login com biometria
  Future<UserModel?> loginWithBiometrics() async {
    final nif = await _storage.read(key: 'saved_nif');
    if (nif == null) return null;

    final bool isAuthenticated = await _localAuth.authenticate(
      localizedReason: 'Use seu rosto ou digital para entrar.',
    );

    if (!isAuthenticated) return null;

    // Recria o usuário com base no NIF salvo
    return UserModel(nif: nif);
  }

  // Logout
  Future<void> logout() async {
    await _storage.delete(key: 'saved_nif');
    await _auth.signOut();
  }
}