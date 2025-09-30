import 'dart:io';

import 'package:cine_favorite/controllers/favorite_movie_controller.dart';
import 'package:cine_favorite/models/favorite_movie.dart';
import 'package:cine_favorite/views/search_movie_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  final _favMovieController = FavoriteMovieController();

  // Função para remover filme
  void _removerFilme(FavoriteMovie movie) async {
    await _favMovieController.removeFavoriteMovie(movie.id!);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("'${movie.title}' removido dos favoritos")),
      );
    }
  }

  // Alterar nota do filme
  void _alterarNota(FavoriteMovie movie) {
    final notaController =
        TextEditingController(text: movie.rating.toStringAsFixed(1));

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Alterar Nota"),
        content: TextField(
          controller: notaController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: "Nota (0-10)",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () async {
              final novaNota = double.tryParse(notaController.text);
              if (novaNota != null && novaNota >= 0 && novaNota <= 10) {
                await _favMovieController.updateMovieRating(movie.id!, novaNota);
                if (mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "Nota de '${movie.title}' atualizada para $novaNota"),
                    ),
                  );
                }
              }
            },
            child: const Text("Salvar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Filmes Favoritos"),
        actions: [
          IconButton(
            onPressed: FirebaseAuth.instance.signOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder<List<FavoriteMovie>>(
        stream: _favMovieController.getFavoriteMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Erro ao carregar favoritos"),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final movies = snapshot.data!;
          if (movies.isEmpty) {
            return const Center(
              child: Text("Nenhum filme favoritado"),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return Card(
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Imagem
                    Expanded(
                      child: movie.posterPath.isNotEmpty
                          ? Image.file(
                              File(movie.posterPath),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                color: Colors.grey[300],
                                child:
                                    const Icon(Icons.broken_image, size: 50),
                              ),
                            )
                          : Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.movie, size: 50),
                            ),
                    ),

                    // Título
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(
                        movie.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    // Nota + editar
                    GestureDetector(
                      onTap: () => _alterarNota(movie),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.star,
                                color: Colors.amber, size: 16),
                            const SizedBox(width: 4),
                            Text(movie.rating.toStringAsFixed(1)),
                            const SizedBox(width: 4),
                            const Icon(Icons.edit,
                                color: Colors.blue, size: 14),
                          ],
                        ),
                      ),
                    ),

                    // Botão excluir
                    TextButton.icon(
                      onPressed: () => _removerFilme(movie),
                      icon: const Icon(Icons.delete, color: Colors.red, size: 18),
                      label: const Text("Remover",
                          style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SearchMovieView()),
        ),
        child: const Icon(Icons.search),
      ),
    );
  }
}
