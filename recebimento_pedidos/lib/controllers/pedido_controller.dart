// lib/models/pedido.dart
import 'package:recebimento_pedidos/models/item_pedido.dart';


class Pedido {
  int? id;
  String dataPedido;
  String status;
  double valorTotal;
  List<ItemPedido> itens; // O pedido terá uma lista de itens

  Pedido({
    this.id,
    required this.dataPedido,
    this.status = 'Em Andamento',
    this.valorTotal = 0.0,
    this.itens = const [], // Inicializa como lista vazia
  });

  // Converte um Map em um objeto Pedido
  factory Pedido.fromMap(Map<String, dynamic> map) {
    return Pedido(
      id: map['id'],
      dataPedido: map['data_pedido'],
      status: map['status'],
      valorTotal: map['valor_total'],
      // Os itens serão carregados separadamente via PedidoController
      itens: [],
    );
  }

  // Converte um objeto Pedido em um Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'data_pedido': dataPedido,
      'status': status,
      'valor_total': valorTotal,
    };
  }
}