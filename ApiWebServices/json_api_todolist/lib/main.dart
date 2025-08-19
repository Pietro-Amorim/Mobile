import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(home: TarefasPage())); // Inicia o app chamando a página de tarefas
}

class TarefasPage extends StatefulWidget {
  const TarefasPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TarefasPageState();
  }
}

class _TarefasPageState extends State<TarefasPage> {
  List<Map<String, dynamic>> tarefas = [];
  final TextEditingController _tarefaController = TextEditingController();
  String baseUrl = "http://10.109.197.38:3006/tarefas"; // URL base da API

  @override
  void initState() {
    super.initState();
    _carregarTarefas(); // Carrega tarefas ao iniciar
  }

  // GET -> Buscar tarefas
  void _carregarTarefas() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        List<dynamic> dados = json.decode(response.body);

        setState(() {
          tarefas = dados.map((item) {
            final tarefa = Map<String, dynamic>.from(item);
            tarefa["concluida"] = tarefa["concluida"] ?? false; // evita null
            return tarefa;
          }).toList();
        });
      }
    } catch (e) {
      print("Erro ao Carregar Tarefas: $e");
    }
  }

  // POST -> Inserir nova tarefa
  void _adicionarTarefa(String titulo) async {
    try {
      final tarefa = {"titulo": titulo, "concluida": false};
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-type": "application/json"},
        body: json.encode(tarefa),
      );

      if (response.statusCode == 201) {
        _tarefaController.clear();
        _carregarTarefas();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Tarefa Adicionada Com Sucesso")),
        );
      }
    } catch (e) {
      print("Erro ao inserir Tarefa: $e");
    }
  }

  // PATCH -> Atualizar status (concluída / pendente)
  void _atualizarTarefa(String id, bool concluida) async {
    try {
      final response = await http.patch(
        Uri.parse("$baseUrl/$id"),
        headers: {"Content-type": "application/json"},
        body: json.encode({"concluida": concluida}),
      );

      if (response.statusCode == 200) {
        _carregarTarefas(); // Atualiza a lista
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Tarefa Atualizada")),
        );
      }
    } catch (e) {
      print("Erro ao Atualizar Tarefa: $e");
    }
  }

  // DELETE -> Remover tarefa
  void _removerTarefa(String id) async {
    try {
      final response = await http.delete(Uri.parse("$baseUrl/$id"));
      if (response.statusCode == 200) {
        _carregarTarefas();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Tarefa Removida Com Sucesso")),
        );
      }
    } catch (e) {
      print("Erro ao Remover Tarefa $e");
    }
  }

  // ---------- INTERFACE ----------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tarefas via API")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Campo de texto para adicionar nova tarefa
            TextField(
              controller: _tarefaController,
              decoration: InputDecoration(
                labelText: "Nova Tarefa",
                border: OutlineInputBorder(),
              ),
              onSubmitted: _adicionarTarefa,
            ),
            SizedBox(height: 10),

            // Lista de tarefas
            Expanded(
              child: tarefas.isEmpty
                  ? Center(child: Text("Nenhuma Tarefa Adicionada"))
                  : ListView.builder(
                      itemCount: tarefas.length,
                      itemBuilder: (context, index) {
                        final tarefa = tarefas[index];

                        return ListTile(
                          // CheckBox que atualiza no banco via PATCH
                          leading: Checkbox(
                            value: tarefa["concluida"] ?? false,
                            onChanged: (valor) {
                              setState(() {
                                tarefa["concluida"] = valor ?? false;
                              });
                              _atualizarTarefa(
                                tarefa["id"].toString(),
                                valor ?? false,
                              );
                            },
                          ),

                          // Título da tarefa
                          title: Text(tarefa["titulo"]),

                          // Status
                          subtitle: Text(
                            (tarefa["concluida"] ?? false)
                                ? "Concluída"
                                : "Pendente",
                          ),

                          // Botão para excluir
                          trailing: IconButton(
                            onPressed: () =>
                                _removerTarefa(tarefa["id"].toString()),
                            icon: Icon(Icons.delete),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
