// lib/models/item_pedido.dart
import 'package:recebimento_pedidos/controllers/produto_controller.dart';

// Importar Produto

class ItemPedido {
  int? id;
  int pedidoId;
  int produtoId;
  int quantidade;
  double precoUnitario;
  double subtotal;
  Produto? produto; // Para facilitar a exibição do produto associado

  ItemPedido({
    this.id,
    required this.pedidoId,
    required this.produtoId,
    required this.quantidade,
    required this.precoUnitario,
    required this.subtotal,
    this.produto,
  });

  // Converte um Map em um objeto ItemPedido
  factory ItemPedido.fromMap(Map<String, dynamic> map) {
    return ItemPedido(
      id: map['id'],
      pedidoId: map['pedido_id'],
      produtoId: map['produto_id'],
      quantidade: map['quantidade'],
      precoUnitario: map['preco_unitario'],
      subtotal: map['subtotal'],
      // O produto associado será carregado separadamente se necessário
    );
  }

  // Converte um objeto ItemPedido em um Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pedido_id': pedidoId,
      'produto_id': produtoId,
      'quantidade': quantidade,
      'preco_unitario': precoUnitario,
      'subtotal': subtotal,
    };
  }
}