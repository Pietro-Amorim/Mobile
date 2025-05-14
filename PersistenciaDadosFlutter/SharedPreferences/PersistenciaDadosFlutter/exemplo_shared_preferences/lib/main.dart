import 'package:exemplo_shared_preferences/tela_inicial.dart';
import 'package:flutter/material.dart';
// import 'tela_inical.dart'; // Removed as the file does not exist

void main(){
  runApp(MaterialApp(
    title: "Exemplo Shared Preferences",
    home: TelaInicial(),
    theme: ThemeData(brightness: Brightness.light),
    darkTheme: ThemeData(brightness: Brightness.dark),
  ));
}