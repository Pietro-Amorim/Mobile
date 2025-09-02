import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blueAccent,  // Definir a cor principal do app
        textTheme: TextTheme(
          titleMedium: TextStyle(color: Colors.black), //Definir a cor do texto padrão
        ),
      ),
      home: PerfilScreen(),
    );
  }
}

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView( // Mudando para ListView para evitar overflow
          children: [
            // Imagem do perfil com sombra
            Center(
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage("https://images.icon-icons.com/2643/PNG/512/male_man_people_person_avatar_white_tone_icon_159363.png"),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black, // Usando uma sombra simples sem opacidade
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ], // Sombras para a imagem do perfil
                ),
              ),
            ),
            SizedBox(height: 16),
            
            // Nome e descrição com alinhamento
            Center(
              child: Column(
                children: [
                  Text(
                    "Pietro Amorim",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Estudante do Senai | Desenvolvedor",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            
            // Linha de ícones de redes sociais
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.facebook, color: Colors.blue),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.discord, color: Colors.purple),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.camera_alt, color: const Color.fromARGB(255, 0, 0, 0)),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 16),
            
            // Containers com bordas arredondadas e sombras
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue, // Usando a cor sem opacidade
                        blurRadius: 5,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Center(child: Text("Seguidores", style: TextStyle(color: Colors.white))),
                ),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 0, 0, 0), // Usando a cor sem opacidade
                        blurRadius: 5,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Center(child: Text("Salvos", style: TextStyle(color: Colors.white))),
                ),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red, // Usando a cor sem opacidade
                        blurRadius: 5,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Center(child: Text("Curtidas", style: TextStyle(color: Colors.white))),
                ),
              ],
            ),
            SizedBox(height: 16),
            
            // Lista de texto com mais espaçamento
            ListTile(
              title: Text("Conversar", style: TextStyle(fontSize: 18)),
              leading: Icon(Icons.email, color: Colors.blue),
            ),
            ListTile(
              title: Text("Grupos em comum", style: TextStyle(fontSize: 18)),
              leading: Icon(Icons.person_4, color: Colors.green),
            ),
            ListTile(
              title: Text("Adicionar contato", style: TextStyle(fontSize: 18)),
              leading: Icon(Icons.add, color: Colors.orange),
            ),
            ListTile(
              title: Text("Bloquear", style: TextStyle(fontSize: 18)),
              leading: Icon(Icons.block, color: Colors.red),
            ),
            ListTile(
              title: Text("Denunciar", style: TextStyle(fontSize: 18)),
              leading: Icon(Icons.security, color: Colors.grey),
            ),
          ],
        ),
      ),
      
      // BottomNavigationBar com personalização
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.blue),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.blue),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.blue),
            label: 'Profile',
          ),
        ],
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
