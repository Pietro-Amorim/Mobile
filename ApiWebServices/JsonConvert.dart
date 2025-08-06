// Teste de Conversão de JSON <-> Dart
import 'dart:convert'; // Biblioteca Nativa -> Não precisa baixar para o Pubspec

void main() {
  String UsuarioJson = '''{
                            "id": "1ab2",
                            "user": "usuario1",
                            "nome": "Pietro",
                            "idade": 18,
                            "cadastrado": true,
                      }''';
    Map<String, dynamic> UsuarioMap = jsonDecode(UsuarioJson);
    print("ID: ${UsuarioMap['id']}");
}