
import 'package:biblioteca_app/views/home_view.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "Biblioteca",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.amber,
      useMaterial3: true
    ),
    home: HomeView(),
  ));
}