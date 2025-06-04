//classe de apoio as conexões do BD
//classe singleton -> instância única
import 'package:path/path.dart';
import 'package:sa_petshop/models/consulta_model.dart';
import 'package:sa_petshop/models/pet_model.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{
  static Database? _database; //obj para criar as conexões com o bd
  // transformar a classe em singleton
  // não permite insanciar um objeo enquanto outro objeto já estiver ativo
  static final DbHelper _instance = DbHelper._internal();
  // construtor para o singleton
  DbHelper._internal();
  factory DbHelper() => _instance;

  // fazer conexão com o banco de dados
  Future<Database> get database async{
    if(_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  } 

  Future<Database> _initDatabase() async{
     //pegar o endereço do bd 
     final dbPath = await getDatabasesPath();
     final path = join(dbPath, 'petshop.db');

     return await openDatabase(
        path,
        version: 1,
        onCreate: _onCreateDB
     );
  }

  Future<void> _onCreateDB(Database db, int version) async{
    await db.execute(
      """CREATE TABLE IF NOT EXISTS pets(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        raca TEXT NOT NULL,
        nome_dono TEXT NOT NULL,
        telefone TEXT NOT NULL
      )
      """
    );
    print("Tabela pets criada com sucesso!");

    //criar a tabela de consultas
    await db.execute(
      """CREATE TABLE IF NOT EXISTS consultas(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        pet_id INTEGER NOT NULL,
        data_hora TEXT NOT NULL,
        tipo_servico TEXT NOT NULL,
        observacao TEXT NOT NULL,
        FOREIGN KEY (pet_id) REFERENCES pets(id) ON DELETE CASCADE
      )
      """
    );
    print("Tabela consultas criada com sucesso!");
  }

  // método crud para pets
  Future<int> insertPet(Pet pet) async {
    final db = await database;
    return await db.insert('pets', pet.toMap()); //retorna o id do pet
  }

  Future<List<Pet>> getPets() async{
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('pets');
    // converter os valores para obj
    return maps.map((e) => Pet.fromMap(e)).toList();
  }

  Future<Pet?> getPetbyId(int id) async{
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('pets', where: 'id = ?', whereArgs: [id]);
    if(maps.isNotEmpty){
      return Pet.fromMap(maps.first);
    } else {
      return null;
    }  
  }

  Future<int> deletePet(int id) async{
    final db = await database;
    return await db.delete('pets', where: 'id = ?', whereArgs: [id]);
    //deleta o pet da tabela que tenha o id igual o enviado como parâmetro
  }

  //métodos CRUD para consultas
  // Create Consulta
  Future<int> insertConsulta(Consulta consulta) async {
    final db = await database;
    return await db.insert('consultas', consulta.toMap());
  }

  // Get Consultas -> By Pet
  Future<List<Consulta>> getConsultaByPetId(int petId) async{
    final db = await database;
    final List<Map<String,dynamic>> maps = await db.query(
      "consultas",
      where: "pet_id = ?",
      whereArgs: [petId],
      orderBy: "data_hora ASC" //ordenar por data e hora da Consulta
    ); // seleciona todas as consultas do pet com o id passado como parâmetro
    // converter os valores da Map para obj
    return maps.map((e) => Consulta.fromMap(e)).toList();
  }

  // Delete Consulta
  Future<int> deleteConsulta(int id) async{
    final db = await database;
    return await db.delete('consultas', where: 'id = ?', whereArgs: [id]);
  }
  
}