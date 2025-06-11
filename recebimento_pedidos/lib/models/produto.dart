// lib/controllers/produto_controller.dart
import 'package:recebimento_pedidos/controllers/produto_controller.dart';
import 'package:sqflite/sqflite.dart';
import '../database/app_database.dart';
import '../models/produto.dart';

class ProdutoController {
  final AppDatabase _appDatabase = AppDatabase();

  // Inserir um novo produto
  Future<int> insertProduto(Produto produto) async {
    final db = await _appDatabase.database;
    return await db.insert(
      'produtos',
      produto.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Obter todos os produtos
  Future<List<Produto>> getProdutos() async {
    final db = await _appDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query('produtos');
    return List.generate(maps.length, (i) {
      return Produto.fromMap(maps[i]);
    });
  }

  // Obter um produto por ID
  Future<Produto?> getProdutoById(int id) async {
    final db = await _appDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'produtos',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Produto.fromMap(maps.first);
    }
    return null;
  }

  // Atualizar um produto existente
  Future<int> updateProduto(Produto produto) async {
    final db = await _appDatabase.database;
    return await db.update(
      'produtos',
      produto.toMap(),
      where: 'id = ?',
      whereArgs: [produto.id],
    );
  }

  // Excluir um produto
  Future<int> deleteProduto(int id) async {
    final db = await _appDatabase.database;
    return await db.delete(
      'produtos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}