// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'cadastro_produto_screen.dart';
import 'menu_produtos_screen.dart';
import 'carrinho_screen.dart';

// Tela inicial do aplicativo, onde o usuário pode escolher entre cadastrar produto,
// visualizar produtos disponíveis e acessar o carrinho (pedido)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recebimento de Pedidos'), // Título da AppBar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centraliza os botões verticalmente
          children: <Widget>[
            // Botão para acessar a tela de cadastro de produto
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CadastroProdutoScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Cadastrar Produto'),
            ),
            const SizedBox(height: 20), // Espaçamento entre os botões

            // Botão para acessar a tela de menu de produtos
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MenuProdutosScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Ver Produtos (Fazer Pedido)'),
            ),
            const SizedBox(height: 20),

            // Botão para acessar a tela do carrinho de pedidos
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CarrinhoScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Ver Carrinho/Pedido'),
            ),
          ],
        ),
      ),
    );
  }
}
