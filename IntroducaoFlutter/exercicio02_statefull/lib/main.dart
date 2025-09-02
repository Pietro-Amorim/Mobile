import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Lista de imagens
  List<String> imagens = [
    "https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0",
    "https://images.unsplash.com/photo-1521747116042-5a810fda9664",
    "https://images.unsplash.com/photo-1504384308090-c894fdcc538d",
    "https://images.unsplash.com/photo-1518837695005-2083093ee35b",
    "https://images.unsplash.com/photo-1501594907352-04cda38ebc29",
    "https://images.unsplash.com/photo-1519681393784-d120267933ba",
    "https://images.unsplash.com/photo-1531259683007-016a7b628fc3",
    "https://images.unsplash.com/photo-1506619216599-9d16d0903dfd",
    "https://images.unsplash.com/photo-1494172961521-33799ddd43a5",
    "https://images.unsplash.com/photo-1517245386807-bb43f82c33c4",
  ];

  final TextEditingController _urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Galeria de Imagens"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Carrossel de Imagens usando PageView
            SizedBox(
              height: 300,
              child: PageView.builder(
                itemCount: imagens.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(imagens[index], fit: BoxFit.cover),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            // Campo de texto para inserir URL da imagem
            TextField(
              controller: _urlController,
              decoration: InputDecoration(
                hintText: 'Cole o URL da imagem aqui',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _adicionarImagem,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Grid de Imagens
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: imagens.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => _mostrarImagem(context, imagens[index]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(imagens[index], fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

 //adicionar imagens
  void _adicionarImagem() {
    final url = _urlController.text.trim();
    if (url.isNotEmpty) {
      setState(() {
        imagens.add(url);
      });
      _urlController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, insira um URL válido')),
      );
    }
  }

  // Função para exibir a imagem em um diálogo
  void _mostrarImagem(BuildContext context, String imagem) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Image.network(imagem),
      ),
    );
  }
}
