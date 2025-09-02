import 'package:biblioteca_app/controllers/livro_controller.dart';
import 'package:biblioteca_app/models/livro_model.dart';
import 'package:flutter/material.dart';

class LivroFormView extends StatefulWidget {
  final LivroModel? livro;

  const LivroFormView({super.key, this.livro});

  @override
  State<LivroFormView> createState() => _LivroFormViewState();
}

class _LivroFormViewState extends State<LivroFormView> {
  // Atributos
  final _formKey = GlobalKey<FormState>();
  final _controller = LivroController();
  final _tituloField = TextEditingController();
  final _autorField = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Preenche os campos se estiver em modo de edição
    if (widget.livro != null) {
      _tituloField.text = widget.livro!.titulo;
      _autorField.text = widget.livro!.autor;
    }
  }

  // Método para criar um novo livro
  void _criar() async {
    if (_formKey.currentState!.validate()) {
      final livroNovo = LivroModel(
        id: DateTime.now().millisecond.toString(),
        titulo: _tituloField.text.trim(),
        autor: _autorField.text.trim(),
        disponivel: true,
      );
      try {
        await _controller.create(livroNovo);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Livro criado com sucesso!')));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao criar livro: ${e.toString()}')));
      }
      Navigator.pop(context);
    }
  }

  // Método para atualizar um livro existente
  void _atualizar() async {
    if (_formKey.currentState!.validate()) {
      final livroAtualizado = LivroModel(
        id: widget.livro!.id,
        titulo: _tituloField.text.trim(),
        autor: _autorField.text.trim(),
        disponivel: widget.livro!.disponivel,
      );
      try {
        await _controller.update(livroAtualizado);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Livro atualizado com sucesso!')));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao atualizar livro: ${e.toString()}')));
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.livro == null ? "Novo Livro" : "Editar Livro"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _tituloField,
                decoration: const InputDecoration(labelText: "Título"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "O título é obrigatório";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _autorField,
                decoration: const InputDecoration(labelText: "Autor"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "O autor é obrigatório";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (widget.livro == null) {
                    _criar();
                  } else {
                    _atualizar();
                  }
                },
                child: Text(widget.livro == null ? "Criar" : "Salvar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
