// lib/screens/carrinho_screen.dart
import 'package:flutter/material.dart';
import '../models/item_pedido.dart';
import '../models/pedido.dart';
import '../controllers/pedido_controller.dart';

class CarrinhoScreen extends StatefulWidget {
  const CarrinhoScreen({super.key});

  @override
  State<CarrinhoScreen> createState() => _CarrinhoScreenState();
}

class _CarrinhoScreenState extends State<CarrinhoScreen> {
  final PedidoController _pedidoController = PedidoController();
  Pedido? _currentPedido;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCurrentPedido();
  }

  Future<void> _loadCurrentPedido() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final pedido = await _pedidoController.getActivePedido();
      setState(() {
        _currentPedido = pedido;
        _isLoading = false;
      });
      if (_currentPedido != null) {
        await _pedidoController.updatePedidoValorTotal(_currentPedido!.id!);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar carrinho: $e')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _removeItem(ItemPedido item) async {
    if (item.id != null) {
      try {
        await _pedidoController.removeItemFromPedido(item.id!);
        // Recarrega o pedido para atualizar a UI e o total
        _loadCurrentPedido();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${item.produto?.nome ?? "Item"} removido do carrinho.')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao remover item: $e')),
        );
      }
    }
  }

  void _finalizarPedido() async {
    if (_currentPedido != null && _currentPedido!.id != null && _currentPedido!.itens.isNotEmpty) {
      try {
        await _pedidoController.finalizarPedido(_currentPedido!.id!);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pedido finalizado com sucesso!')),
        );
        // Opcional: Navegar de volta para a tela inicial ou limpar o carrinho
        Navigator.popUntil(context, (route) => route.isFirst); // Volta para a Home
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao finalizar pedido: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Carrinho vazio ou pedido inválido para finalizar.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Carrinho/Pedido'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadCurrentPedido,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _currentPedido == null || _currentPedido!.itens.isEmpty
              ? const Center(
                  child: Text('Seu carrinho está vazio. Adicione produtos no "Menu de Produtos".'),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: _currentPedido!.itens.length,
                        itemBuilder: (context, index) {
                          final item = _currentPedido!.itens[index];
                          final produtoNome = item.produto?.nome ?? 'Produto Desconhecido';
                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: ListTile(
                              title: Text('$produtoNome (x${item.quantidade})'),
                              subtitle: Text(
                                'Preço Unitário: R\$ ${item.precoUnitario.toStringAsFixed(2)}\nSubtotal: R\$ ${item.subtotal.toStringAsFixed(2)}',
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.remove_circle, color: Colors.red),
                                onPressed: () => _removeItem(item),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'Total do Pedido: R\$ ${_currentPedido!.valorTotal.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton.icon(
                            onPressed: _finalizarPedido,
                            icon: const Icon(Icons.check_circle),
                            label: const Text('Finalizar Pedido'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                              textStyle: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}