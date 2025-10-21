import 'package:firebase_auth/firebase_auth.dart';
import 'package:local_auth/local_auth.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<User?> loginEmail(String email, String senha) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: senha);
      return user.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> loginBiometria() async {
    try {
      bool canCheck = await _localAuth.canCheckBiometrics;
      if (!canCheck) return false;

      bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'Autentique-se com biometria',
      );
      return didAuthenticate;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
