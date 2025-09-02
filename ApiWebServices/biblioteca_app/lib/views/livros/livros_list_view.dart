import 'package:biblioteca_app/controllers/livro_controller.dart';
import 'package:biblioteca_app/models/livro_model.dart';
import 'package:biblioteca_app/views/livros/livros_form_view.dart';
import 'package:flutter/material.dart';

class LivroListView extends StatefulWidget {
  const LivroListView({super.key});

  @override
  State<LivroListView> createState() => _LivroListViewState();
}

class _LivroListViewState extends State<LivroListView> {
  // atributos
  final _buscarField = TextEditingController();
  List<LivroModel> _livrosFiltrados = [];
  final _controller = LivroController(); // controller para conectar model/view
  List<LivroModel> _livros = []; // lista para guardar os livros
  bool _carregando = true; // bool para usar no view

  @override
  void initState() {
    // carregar os dados antes da construção da tela
    super.initState();
    _load(); // método para carregar dados da api
  }

  _load() async {
    setState(() {
      _carregando = true;
    });
    try {
      _livros = await _controller.fetchAll(); // preenche a lista com os livros do BD
      _livrosFiltrados = _livros;
    } catch (e) {
      // caso erro, mostra para o usuário
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    setState(() {
      // modifica a variável para false - terminou de carregar
      _carregando = false;
    });
  }

  // método para filtrar livros pelo título e pelo autor
  void _filtrar() {
    // filtrar da lista já carregada
    final busca = _buscarField.text.toLowerCase();
    setState(() {
      _livrosFiltrados = _livros.where((livro) {
        return livro.titulo.toLowerCase().contains(busca) || // filtra pelo título
            livro.autor.toLowerCase().contains(busca); // filtra pelo autor
      }).toList(); // converte em Lista
    });
  }

  // criar método deletar
  void _delete(LivroModel livro) async {
    if (livro.id == null) return; // interrompe o método
    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirma Exclusão"),
        content: Text("Deseja realmente excluir o livro ${livro.titulo}"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Ok"),
          ),
        ],
      ),
    );
    if (confirme == true) {
      try {
        await _controller.delete(livro.id!);
        _load();
      } catch (e) {
        // tratar erro
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  // método para navegar para Tela LivroFormView
  void _openForm() async {
    //usuário entra no parametro, mas não é obrigatório
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LivroFormView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Livros"),
      ),
      body: _carregando
          ? const Center(
              child: CircularProgressIndicator(),
            ) // mostra uma barra circular
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _buscarField,
                    decoration: const InputDecoration(labelText: "Pesquisar Livro"),
                    onChanged: (value) => _filtrar(),
                  ),
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _livrosFiltrados.length,
                    itemBuilder: (context, index) {
                      final livro = _livrosFiltrados[index];
                      return Card(
                        child: ListTile(
                          leading: IconButton(
                            onPressed: () => _openForm(),
                            icon: const Icon(Icons.edit),
                          ),
                          title: Text(livro.titulo),
                          subtitle: Text(livro.autor),
                          trailing: IconButton(
                            onPressed: () => _delete(livro),
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}