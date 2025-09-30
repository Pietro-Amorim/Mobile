import 'dart:io';

import 'package:cine_favorite/models/favorite_movie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class FavoriteMovieController {
  final _auth = FirebaseAuth.instance; // conecta com Auth do Firebase
  final _db = FirebaseFirestore.instance; // conecta com Firestore

  User? get currentUser => _auth.currentUser;

  // Adicionar filme aos favoritos
  Future<void> addFavorite(Map<String, dynamic> movieData) async {
    final imagemUrl =
        "https://image.tmdb.org/t/p/w500${movieData["poster_path"]}";

    // Baixa a imagem
    final responseImg = await http.get(Uri.parse(imagemUrl));

    // Salva localmente
    final imagemDir = await getApplicationDocumentsDirectory();
    final imagemFile = File("${imagemDir.path}/${movieData["id"]}.jpg");
    await imagemFile.writeAsBytes(responseImg.bodyBytes);

    // Cria objeto
    final movie = FavoriteMovie(
      id: movieData["id"],
      title: movieData["title"],
      posterPath: imagemFile.path, // <- salva o caminho local, não só o poster_path da API
      rating: 0, // default caso não tenha
    );

    // Salva no Firestore
    await _db
        .collection("users")
        .doc(currentUser!.uid)
        .collection("favorite_movies")
        .doc(movie.id.toString())
        .set(movie.toMap());
  }

  // Lista de favoritos
  Stream<List<FavoriteMovie>> getFavoriteMovies() {
    if (currentUser == null) return Stream.value([]);

    return _db
        .collection("users")
        .doc(currentUser!.uid)
        .collection("favorite_movies")
        .snapshots()
        .map((snap) =>
            snap.docs.map((doc) => FavoriteMovie.fromMap(doc.data())).toList());
  }

  // Remover favorito
  Future<void> removeFavoriteMovie(int movieId) async {
    if (currentUser == null) return;

    // Remove do Firestore
    await _db
        .collection("users")
        .doc(currentUser!.uid)
        .collection("favorite_movies")
        .doc(movieId.toString())
        .delete();

    // Remove imagem local
    final imagemPath = await getApplicationDocumentsDirectory();
    final imagemFile = File("${imagemPath.path}/$movieId.jpg");
    try {
      if (await imagemFile.exists()) {
        await imagemFile.delete();
      }
    } catch (e) {
      print("Erro ao deletar img: $e");
    }
  }

  // Atualizar nota
  Future<void> updateMovieRating(int movieId, double rating) async {
    if (currentUser == null) return;

    await _db
        .collection("users")
        .doc(currentUser!.uid)
        .collection("favorite_movies")
        .doc(movieId.toString())
        .update({"rating": rating});
  }
}
