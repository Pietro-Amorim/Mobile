import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
void main(){
  runApp(MaterialApp(
    home: LocationScreen(),
  ));
}

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  //atributos
  String locationMessage = "Localização Não Encontrada";

  void getLocation() async{
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );
    setState(() {
      locationMessage = "Latitude: ${position.latitude}, Longitude ${position.longitude}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GPS - Localização"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(locationMessage),
            ElevatedButton(
              onPressed: getLocation, 
              child: Text("Obter Localização"))
          ],
        ),
      ),
    );
  }
}