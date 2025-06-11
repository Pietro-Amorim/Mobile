// lib/models/produto.dart
class Produto {
  int? id;
  String nome;
  String descricao;
  double preco;
  String categoria;

  Produto({
    this.id,
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.categoria,
  });

  // Converte um Map (vindo do banco de dados) em um objeto Produto
  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
      id: map['id'],
      nome: map['nome'],
      descricao: map['descricao'],
      preco: map['preco'],
      categoria: map['categoria'],
    );
  }

  // Converte um objeto Produto em um Map (para salvar no banco de dados)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'preco': preco,
      'categoria': categoria,
    };
  }
}