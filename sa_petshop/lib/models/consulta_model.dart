import 'package:intl/intl.dart';

class Consulta{
  final int? id; //pode ser nulo
  final int petId; //chave estrangeita
  final DateTime dataHora;
  final String tipoServico;
  final String observacao;

  Consulta({
    this.id,
    required this.petId,
    required this.dataHora,
    required this.tipoServico,
    required this.observacao
  });

  // toMap : Obj => BD
  Map<String,dynamic> toMap() => {
    "id":id,
    "pet_id":petId,
    "data_hora": dataHora.toIso8601String(), // padrão internacional de hora para BD
    "tipo_servico":tipoServico,
    "observacao":observacao
    };

  // fromMap : BD => Obj
  factory Consulta.fromMap(Map<String, dynamic> map)=>
    Consulta(
      id: map['id'] as int?, // pode ser nulo
      petId: map['pet_id'] as int,
      dataHora: DateTime.parse(map['data_hora'] as String), // converte string para DateTime
      tipoServico: map['tipo_servico'] as String,
      observacao: map['observacao'] as String,
    );


  // metodo de conversão de data e hora para formato BR
  String get dataHoraLocal {
    final local = DateFormat("dd/MM/yyyy HH:mm");
    return local.format(dataHora);
    
  } 
}