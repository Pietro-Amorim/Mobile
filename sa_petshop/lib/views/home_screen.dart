import 'package:flutter/material.dart';
import 'package:sa_petshop/controllers/path_controller.dart';
import 'package:sa_petshop/models/pet_model.dart';
import 'package:sa_petshop/views/cadastro_pet_screen.dart';
import 'package:sa_petshop/views/detalhe_pet_screen.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  //atributos
  final PetController _petController = PetController();
  List<Pet> _pets = [];
  bool _isLoading = true; //enquanto carrega info do BD

  @override
  void initState() {  //método para rodar antes de qualquer coisa(busca as informações antes de buildar a tela)
    super.initState();
    _carregarDados();
  }

  _carregarDados() async{
    setState(() {
      _isLoading = true;
    });
    try {
      _pets = await _petController.readPets();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Exception: $e")));
    }finally{ //execução obrigatória
      setState(() {
        _isLoading = false;
      });
    }
  }

  //buildar a tela
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("PetShop - Clientes"),),
      body: _isLoading //operador ternário
        ? Center(child: CircularProgressIndicator(),)
        : Padding(
            padding: EdgeInsets.all(16),
            child: ListView.builder( //construtor da lista
              itemCount: _pets.length,
              itemBuilder: (context, index) {
                final pet = _pets[index];
                return ListTile(  //item da lista
                  title: Text("${pet.nome} - ${pet.raca}"),
                  subtitle: Text("${pet.nomeDono} - ${pet.telefone}"),
                  // onTap -> navegar para os detalhes do pet
                  onTap: () => Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => DetalhePetScreen(petId: pet.id!))),
                  //onLongPress -> excluir o pet
                );
              }),
            ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Adicionar Pet",
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(context, // navegação para a tela de cadastro
          MaterialPageRoute(builder: (context) => CadastroPetScreen()));
        },
      ),
    );
  }
}