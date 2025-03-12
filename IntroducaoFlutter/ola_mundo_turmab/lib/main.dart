import 'package:flutter/material.dart'; //ANDROID

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     home:Scaffold(
      appBar:AppBar(
        title: Text("Meu Primeiro App"),
      ),
      body: Center(
        child: Text("Olá, Mundo!!!")
      )
     )
   );
  } 

}