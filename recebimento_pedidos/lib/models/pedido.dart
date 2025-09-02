// lib/controllers/pedido_controller.dart
import 'package:recebimento_pedidos/controllers/pedido_controller.dart';
import 'package:recebimento_pedidos/controllers/produto_controller.dart';
import 'package:sqflite/sqflite.dart';
import '../database/app_database.dart';
import '../models/item_pedido.dart';
// Para carregar o produto associado ao item

class PedidoController {
  final AppDatabase _appDatabase = AppDatabase();

  // Iniciar um novo pedido
  Future<int> createPedido() async {
    final db = await _appDatabase.database;
    final Pedido novoPedido = Pedido(
      dataPedido: DateTime.now().toIso8601String(), // Data atual
    );
    return await db.insert(
      'pedidos',
      novoPedido.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Adicionar um item a um pedido existente
  Future<int> addItemToPedido(ItemPedido item) async {
    final db = await _appDatabase.database;

    // Verificar se o item já existe para o mesmo produto no mesmo pedido
    // Se existir, apenas atualiza a quantidade e subtotal
    final existingItems = await db.query(
      'itens_pedido',
      where: 'pedido_id = ? AND produto_id = ?',
      whereArgs: [item.pedidoId, item.produtoId],
    );

    if (existingItems.isNotEmpty) {
      final existingItem = ItemPedido.fromMap(existingItems.first);
      final newQuantity = existingItem.quantidade + item.quantidade;
      final newSubtotal = newQuantity * item.precoUnitario;

      await db.update(
        'itens_pedido',
        {'quantidade': newQuantity, 'subtotal': newSubtotal},
        where: 'id = ?',
        whereArgs: [existingItem.id],
      );
      return existingItem.id!; // Retorna o ID do item atualizado
    } else {
      // Se não existir, insere um novo item
      return await db.insert(
        'itens_pedido',
        item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  // Obter um pedido (geralmente o pedido "em andamento" ou o último criado)
  Future<Pedido?> getActivePedido() async {
    final db = await _appDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'pedidos',
      orderBy: 'id DESC', // Pega o último pedido criado
      limit: 1,
    );

    if (maps.isNotEmpty) {
      final Pedido pedido = Pedido.fromMap(maps.first);
      pedido.itens = await getItensDoPedido(pedido.id!);
      return pedido;
    }
    return null;
  }

  // Obter todos os itens de um pedido específico
  Future<List<ItemPedido>> getItensDoPedido(int pedidoId) async {
    final db = await _appDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'itens_pedido',
      where: 'pedido_id = ?',
      whereArgs: [pedidoId],
    );

    List<ItemPedido> itens = [];
    for (var map in maps) {
      final item = ItemPedido.fromMap(map);
      // Carregar o produto associado
      final produtoMap = await db.query(
        'produtos',
        where: 'id = ?',
        whereArgs: [item.produtoId],
      );
      if (produtoMap.isNotEmpty) {
        item.produto = Produto.fromMap(produtoMap.first);
      }
      itens.add(item);
    }
    return itens;
  }

  // Remover um item do pedido
  Future<int> removeItemFromPedido(int itemId) async {
    final db = await _appDatabase.database;
    return await db.delete(
      'itens_pedido',
      where: 'id = ?',
      whereArgs: [itemId],
    );
  }

  // Atualizar o valor total de um pedido
  Future<void> updatePedidoValorTotal(int pedidoId) async {
    final db = await _appDatabase.database;
    final itens = await getItensDoPedido(pedidoId);
    double total = 0.0;
    for (var item in itens) {
      total += item.subtotal;
    }
    await db.update(
      'pedidos',
      {'valor_total': total},
      where: 'id = ?',
      whereArgs: [pedidoId],
    );
  }

  // Marcar um pedido como finalizado (ou mudar status)
  Future<int> finalizarPedido(int pedidoId) async {
    final db = await _appDatabase.database;
    return await db.update(
      'pedidos',
      {'status': 'Finalizado'},
      where: 'id = ?',
      whereArgs: [pedidoId],
    );
  }

  // Excluir um pedido (e seus itens, devido ao ON DELETE CASCADE)
  Future<int> deletePedido(int pedidoId) async {
    final db = await _appDatabase.database;
    return await db.delete(
      'pedidos',
      where: 'id = ?',
      whereArgs: [pedidoId],
    );
  }
}