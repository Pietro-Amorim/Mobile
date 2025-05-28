class Pet{
  //atributos
  // final = no primeiro momento, não pode ser alterado,após mudar o valor, não pode ser alterado
  final int? id;  //pode ser nulo
  final String nome;
  final String raca;
  final String nomeDono;
  final String telefone;

  // métodos -> construtor
  Pet({
    this.id,
    required this.nome,
    required this.raca,
    required this.nomeDono,
    required this.telefone,
  });

  // métodos de conversão de OBJ <=> BD

  //toMap : obj => BD
  Map<String, dynamic> toMap(){
    return {
      'id': id,  //pode ser nulo
      'nome': nome,
      'raca': raca,
      'nome_dono': nomeDono,
      'telefone': telefone,
    };
  }

  //fromMap : BD => obj
  factory Pet.fromMap(Map<String, dynamic> map){
    return new Pet(
      id: map['id'] as int, // cast
      nome: map['nome'] as String,
      raca: map['raca'] as String,
      nomeDono: map['nome_dono'] as String,
      telefone: map['telefone'] as String,
    );
  }

}