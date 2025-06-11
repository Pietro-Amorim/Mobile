// lib/screens/menu_produtos_screen.dart
import 'package:flutter/material.dart';
import 'package:recebimento_pedidos/models/pedido.dart';
import '../models/produto.dart';
import '../models/item_pedido.dart';
import '../controllers/produto_controller.dart';
import '../controllers/pedido_controller.dart';
import 'carrinho_screen.dart'; // Para navegar para o carrinho

class MenuProdutosScreen extends StatefulWidget {
  const MenuProdutosScreen({super.key});

  @override
  State<MenuProdutosScreen> createState() => _MenuProdutosScreenState();
}

class _MenuProdutosScreenState extends State<MenuProdutosScreen> {
  final ProdutoController _produtoController = ProdutoController();
  final PedidoController _pedidoController = PedidoController();
  List<Produto> _produtos = [];
  bool _isLoading = true;
  int? _activePedidoId; // ID do pedido atual (carrinho)

  @override
  void initState() {
    super.initState();
    _loadProdutosAndActivePedido();
  }

  Future<void> _loadProdutosAndActivePedido() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final produtos = await _produtoController.getProdutos();
      // Tenta pegar o pedido ativo, se não houver, cria um novo
      var activePedido = await _pedidoController.getActivePedido();
      if (activePedido == null) {
        _activePedidoId = await _pedidoController.createPedido();
      } else {
        _activePedidoId = activePedido.id;
      }
      setState(() {
        _produtos = produtos;
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar produtos: $e')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _adicionarAoCarrinho(Produto produto) {
    showDialog(
      context: context,
      builder: (context) {
        int quantidade = 1;
        return AlertDialog(
          title: Text('Adicionar ${produto.nome} ao Carrinho'),
          content: TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Quantidade'),
            onChanged: (value) {
              quantidade = int.tryParse(value) ?? 1;
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (quantidade > 0 && _activePedidoId != null) {
                  final item = ItemPedido(
                    pedidoId: _activePedidoId!,
                    produtoId: produto.id!,
                    quantidade: quantidade,
                    precoUnitario: produto.preco,
                    subtotal: produto.preco * quantidade,
                  );
                  try {
                    await _pedidoController.addItemToPedido(item);
                    await _pedidoController.updatePedidoValorTotal(_activePedidoId!);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${produto.nome} adicionado ao carrinho!')),
                    );
                    Navigator.pop(context); // Fecha o dialog
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Erro ao adicionar ao carrinho: $e')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Quantidade inválida ou pedido não iniciado.')),
                  );
                }
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu de Produtos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadProdutosAndActivePedido,
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CarrinhoScreen()),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _produtos.isEmpty
              ? const Center(
                  child: Text('Nenhum produto cadastrado. Cadastre um produto na tela inicial.'),
                )
              : ListView.builder(
                  itemCount: _produtos.length,
                  itemBuilder: (context, index) {
                    final produto = _produtos[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        title: Text(produto.nome),
                        subtitle: Text(
                          '${produto.descricao}\nPreço: R\$ ${produto.preco.toStringAsFixed(2)}\nCategoria: ${produto.categoria}',
                        ),
                        isThreeLine: true,
                        trailing: IconButton(
                          icon: const Icon(Icons.add_shopping_cart, color: Colors.blue),
                          onPressed: () => _adicionarAoCarrinho(produto),
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar para o carrinho diretamente
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CarrinhoScreen()),
          );
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}