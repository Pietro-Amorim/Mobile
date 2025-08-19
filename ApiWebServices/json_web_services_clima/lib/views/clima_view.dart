import 'package:flutter/material.dart';
import 'package:json_web_services_clima/controllers/clima_controller.dart';
import 'package:json_web_services_clima/models/clima_model.dart';

class ClimaView extends StatefulWidget{
  const ClimaView({
    super.key
  });

  @override
  State<StatefulWidget> createState() {
    return _ClimaViewState();
  }
}

class _ClimaViewState extends State<ClimaView>{
  //atributos
  final TextEditingController _cidadeController = TextEditingController();
  ClimaModel? _clima;
  String? _erro;
  final ClimaController _climaController = ClimaController();

  //método para busca clima da cidade
  void _buscar() async{
    try {
      final cidade = _cidadeController.text.trim();
      final resultado = await _climaController.buscarClima(cidade);
      setState(() {
        if(resultado != null){
          _clima = resultado;
          _erro = null;
        } else{
          _clima = null;
          _erro = "Cidade Não Encontrada";
        }
      });
    } catch (e) {
      print("Erro ao buscar Cidade: $e");
    }
  }

  // build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clima em tempo Real"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _cidadeController,
              decoration: const InputDecoration(
                labelText: "Digite uma Cidade",
              ),
            ),
            ElevatedButton(
              onPressed: _buscar,
              child: const Text("Buscar Clima"),
            ),
            SizedBox(height: 20),
            if (_clima != null) ...[
              Text("Cidade: ${_clima!.cidade}"),
              Text("Temperatura: ${_clima!.temperatura}°C"),
              Text("Descrição: ${_clima!.descricao}"),
            ] else if (_erro != null) ...[
              Text(_erro!, style: const TextStyle(color: Color.fromARGB(255, 255, 0, 0))),
            ] else ... [
              Text("Procure uma cidade")
            ]
          ],
        ),
      ),
    );
  }
}