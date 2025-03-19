import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main(){
  runApp(MyApp()); //Classe principal da aplicação
}

//criar a classe principal
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Exemplo de uso do pubspec"),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: (){
              Fluttertoast.showToast(
                msg: "Ola mundo",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM);
                
            }, 
            child: Text("Clique aqui!")),

        ),
      ),
    );

  }
}