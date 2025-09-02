import '../models/livro_model.dart';
import '../services/api_service.dart';

class LivroController {
  // O método fetchAll agora busca livros da API e ordena pelo título.
  Future<List<LivroModel>> fetchAll() async {
    final list = await ApiService.getList("livros?_sort=titulo"); // Ordena pelo título
    return list.map<LivroModel>((item) => LivroModel.fromJson(item)).toList();
  }

  // O método fetchOne busca um livro específico por ID.
  Future<LivroModel> fetchOne(String id) async {
    final livro = await ApiService.getOne("livros", id);
    return LivroModel.fromJson(livro);
  }

  // O método create envia os dados de um novo livro para a API.
  Future<LivroModel> create(LivroModel l) async {
    final created = await ApiService.post("livros", l.toJson());
    return LivroModel.fromJson(created);
  }

  // O método update envia os dados de um livro atualizado para a API.
  Future<LivroModel> update(LivroModel l) async {
    final updated = await ApiService.put("livros", l.toJson(), l.id!);
    return LivroModel.fromJson(updated);
  }

  // O método delete remove um livro da API.
  Future<void> delete(String id) async {
    await ApiService.delete("livros", id);
  }
}
