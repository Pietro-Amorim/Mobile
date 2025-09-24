import 'package:flutter/material.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Meus Filmes Favoritos',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.grey[900], // Cinza-escuro
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Navegar para tela de busca
            },
            tooltip: 'Buscar filmes',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Recarregar lista
            },
            tooltip: 'Recarregar',
          ),
        ],
      ),
      body: Container(), // Seu conteúdo aqui
    );
  }
}