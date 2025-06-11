// lib/screens/cadastro_produto_screen.dart
import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../controllers/produto_controller.dart';

// Tela de cadastro de um novo produto
class CadastroProdutoScreen extends StatefulWidget {
  const CadastroProdutoScreen({super.key});

  @override
  State<CadastroProdutoScreen> createState() => _CadastroProdutoScreenState();
}

class _CadastroProdutoScreenState extends State<CadastroProdutoScreen> {
  // Chave para o formulário
  final _formKey = GlobalKey<FormState>();

  // Controladores para os campos do formulário
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _precoController = TextEditingController();
  final _categoriaController = TextEditingController();

  // Instância do controller responsável pela lógica de inserção
  final ProdutoController _produtoController = ProdutoController();

  // Função chamada ao pressionar o botão de cadastro
  void _cadastrarProduto() async {
    // Valida os campos do formulário
    if (_formKey.currentState!.validate()) {
      // Cria um novo objeto Produto com os dados informados
      final novoProduto = Produto(
        nome: _nomeController.text,
        descricao: _descricaoController.text,
        preco: double.parse(_precoController.text),
        categoria: _categoriaController.text,
      );

      try {
        // Tenta inserir o produto no banco de dados
        await _produtoController.insertProduto(novoProduto);

        // Mostra mensagem de sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Produto cadastrado com sucesso!')),
        );

        // Limpa os campos após o cadastro
        _nomeController.clear();
        _descricaoController.clear();
        _precoController.clear();
        _categoriaController.clear();
      } catch (e) {
        // Mostra mensagem de erro caso ocorra falha
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao cadastrar produto: $e')),
        );
      }
    }
  }

  // Libera recursos dos controladores ao encerrar a tela
  @override
  void dispose() {
    _nomeController.dispose();
    _descricaoController.dispose();
    _precoController.dispose();
    _categoriaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Produto'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Formulário com chave para validação
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Campo: Nome do Produto
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome do Produto'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do produto';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Campo: Descrição
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(labelText: 'Descrição'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a descrição';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Campo: Preço
              TextFormField(
                controller: _precoController,
                decoration: const InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o preço';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor, insira um preço válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Campo: Categoria
              TextFormField(
                controller: _categoriaController,
                decoration: const InputDecoration(labelText: 'Categoria'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a categoria';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Botão: Cadastrar
              ElevatedButton(
                onPressed: _cadastrarProduto,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
