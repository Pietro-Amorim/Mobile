import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegistroCard extends StatelessWidget {
  final DateTime dataHora;
  final double latitude;
  final double longitude;

  RegistroCard({required this.dataHora, required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(dataHora);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ListTile(
        leading: Icon(Icons.location_on),
        title: Text('Registrado em $formattedDate'),
        subtitle: Text('Lat: $latitude, Lon: $longitude'),
      ),
    );
  }
}
