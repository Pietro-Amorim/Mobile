import 'package:flutter/material.dart';
import 'package:json_shared_preferences/tela_inicial.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';// pacote para manipular Json - ja vem com o Dart (não é necessário instalar no pubspec.yaml)

void main() {
  runApp(MaterialApp(
    home: ConfigPage(),
  ));
}

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});


  @override
  State<StatefulWidget> createState() {
    return _ConfigPageState();
  }
  
}

class _ConfigPageState extends State<ConfigPage> {
  //atributos
  bool temaEscuro = false;
  String nomeUsuario = ""; // text void 
  // método que roda antes de carregar a página
  @override
  void initState() {
    super.initState();
    carregarPreferencias();
  }
// método para carregar as informações do sharedPreferences
  void carregarPreferencias() async{
    final prefs = await SharedPreferences.getInstance(); //conexão com o SharedPreferences
    String? jsonString = prefs.getString("config"); // estou recebendo os valores referentes a chave "config" do SharedPreferences
    if(jsonString != null){
      Map<String,dynamic> config = json.decode(jsonString);
      setState(() { // método para mudança de estado
        temaEscuro = config["temaEscuro"] ?? false; // se não existir a chave "temaEscuro", o valor padrão será false
        nomeUsuario = config["nomeUsuario"] ?? ""; // || ;  ?? operador que substitiu o if - operador para elemento vazio
      });
    }
  }

// construção da tela
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App de Configurações",
      theme: temaEscuro ? ThemeData.dark() : ThemeData.light(), // Operador ternário (abreviação para if-else)
      home: TelaInicial(
          temaEscuro: temaEscuro, nomeUsuario: nomeUsuario
      )
    );
  }



}