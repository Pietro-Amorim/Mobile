import 'package:firebase_auth/firebase_auth.dart';

/// Controlador responsável pela autenticação do usuário usando
/// o Firebase Authentication (email e senha).
///
/// Fornece métodos para login, registro e logout, além de acesso
/// ao usuário atualmente autenticado.
class AuthController {
  // Instância singleton do FirebaseAuth (recomendada pela documentação oficial)
  // Garante que todos os métodos usem a mesma instância do serviço de autenticação.
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Retorna o usuário atualmente logado, ou `null` se nenhum usuário estiver autenticado.
  ///
  /// Útil para verificar rapidamente o estado de autenticação em qualquer parte do app.
  User? get currentUser => _auth.currentUser;

  /// Realiza o login de um usuário existente com e-mail e senha.
  ///
  /// [email] deve ser um endereço de e-mail válido.
  /// [password] deve ter pelo menos 6 caracteres (regra do Firebase).
  ///
  /// Retorna o objeto [User] em caso de sucesso.
  /// Lança uma exceção do tipo [FirebaseAuthException] em caso de erro
  /// (ex: credenciais inválidas, usuário não encontrado, etc.).
  Future<User?> login(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      // Re-lança a exceção para que a camada de UI (ex: LoginView)
      // possa exibi-la ao usuário de forma amigável.
      rethrow;
    }
  }

  /// Registra um novo usuário com e-mail e senha.
  ///
  /// O Firebase cria automaticamente uma conta e envia um e-mail de verificação
  /// (opcional, dependendo da configuração do projeto no console do Firebase).
  ///
  /// Retorna o objeto [User] recém-criado.
  /// Pode lançar exceções como:
  /// - "email already in use"
  /// - "invalid email"
  /// - "weak password"
  Future<User?> register(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      // Re-lança para tratamento na UI
      rethrow;
    }
  }

  /// Realiza o logout do usuário atual.
  ///
  /// Limpa a sessão local e invalida o token de autenticação.
  /// Após esta chamada, [currentUser] será `null`.
  Future<void> logout() async {
    await _auth.signOut();
  }
}