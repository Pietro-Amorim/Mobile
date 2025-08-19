import 'dart:convert' show json;

import 'package:http/http.dart' as http show get;
import 'package:json_web_services_clima/models/clima_model.dart';

class ClimaController {
  final String apiKey = "c0c3d21e36538487b077544ae1114145";

  // metodo para buscar o clima de uma cidade
  // metodo get
  Future<ClimaModel?> buscarClima(String cidade) async{
    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=$cidade&appid=$_apiKey&unit=metric&lang=pt_br"
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final dados = json.decode(response.body);
      return ClimaModel.fromJson(dados);
    }else{
      return null; // Retorna null se a requisição falhar
    }
  } 
}

