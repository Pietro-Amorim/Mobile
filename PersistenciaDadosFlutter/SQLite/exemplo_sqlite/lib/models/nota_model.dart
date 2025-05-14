class Nota{
  // Atributos = colunas BD
  final int? id;
  final String? titulo;
  final String? conteudo;

  //construtor
  Nota({this.id, required this.titulo, required this.conteudo});

  // métodos

  // métodos de conversão para objeto <=> BD

  // toMap Objeto => BD
  Map<String, dynamic> toMap(){
    return{
      'id': id, //inicialmente null
      'titulo': titulo,
      'conteudo': conteudo,
    };
  }

  // fromMap BD => Objeto
  factory Nota.fromMap(Map<String, dynamic> map){
    return Nota(
      id: map['id'] as int, //convertendo para int(cast)
      titulo: map['titulo'] as String,    //convertendo para String(cast)
      conteudo: map['conteudo'] as String,//   ||        ||      ||
    );

  }
}