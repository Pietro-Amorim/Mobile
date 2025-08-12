import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_shared_preferences/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaInicial extends StatefulWidget{
  final bool temaEscuro;  // final - tipo de variavel que inicialmente não tem valor inicial, e me permite trocar o valor dela apenas uma vez
  final String nomeUsuario;

  // construtor
  TelaInicial({
    required this.temaEscuro,
    required this.nomeUsuario,
  });

  @override
  State<StatefulWidget> createState() {
    return _TelaInicialState();
  }
} 

class _TelaInicialState extends State<TelaInicial> {
  late bool _temaEscuro; // late - variável que será inicializada depois (atribuir valor depois)
  late TextEditingController _nomeController;

  @override
  void initState() {
    super.initState();
    _temaEscuro = widget.temaEscuro; // acessando o velor do widgetFul
    _nomeController = TextEditingController(text: widget.nomeUsuario); // atribuindo o valor do nomeUsuario da TelaInicial
  }

  // métodos para modificações das configurações
  void _salvarConfiguracoes() async{
    final prefs = await SharedPreferences.getInstance(); 
    Map<String, dynamic> config = {
      "temaEscuro": _temaEscuro,
      "nomeUsuario": _nomeController.text.trim(), // trim() remove espaços em branco no início e no final
    };
    String jsonString = json.encode(config);
    prefs.setString("config", jsonString); 
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Configurações salvas com sucesso!"))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preferências do Usuário"),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: Text("Tema Escuro"),
              value: _temaEscuro,
              onChanged: (bool value) {
                setState(() {
                  _temaEscuro = value;
                });
              },
            ),
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: "Nome do Usuário"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: ()async {
                 _salvarConfiguracoes();
                // reiniciar o aplicativo para aplicar o tema
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => ConfigPage()));
              },
              child: Text("Salvar Configurações"),),
            SizedBox(height: 20,),
            Divider(),
            Text("Configurações Atuais:", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 15,),
            Text("Tema Escuro: ${_temaEscuro ? "Escuro" : "Claro"}"),
            Text("Nome do Usuário: ${_nomeController.text}"),
          ],
        ),
      ),
    );  
  }  
}