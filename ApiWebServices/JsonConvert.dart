//Teste de Conversão Json <-> Dart
import 'dart:convert'; //nativa -> não precisa baixar para o pubspec

void main(){
  // tenho um texto em formato de Json
  String UsuarioJson = '''{
                            "id": "1ab2",
                            "user": "usuario1",
                            "nome": "Pedro",
                            "idade": 25,
                            "cadastrado": true
                      }''';
  // para manipular esse texto
  //converter(decode) Json -> em Map
  Map<String,dynamic> usuario = json.decode(UsuarioJson);
  // Manipulando as informações do Json -> Map
  print(usuario["idade"]);
  usuario["idade"] = 26;
  // converter(encode) Map -> Json
  UsuarioJson = json.encode(usuario);
  //tenho novamente um Json em formato de Texto
  print(UsuarioJson); 
}