// lib/view/photo_detail_screen.dart
import 'package:flutter/material.dart';
import '../models/photo_model.dart';

class PhotoDetailScreen extends StatelessWidget {
  final PhotoModel photo;

  const PhotoDetailScreen({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detalhes da Foto")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.file(photo.imageFile, height: 300),
          const SizedBox(height: 20),
          Text("📅 Data: ${photo.dateTime.toString().split('.')[0]}"),
          Text(
              "📍 Localização: ${photo.latitude?.toStringAsFixed(5) ?? 'Desconhecida'}, ${photo.longitude?.toStringAsFixed(5) ?? 'Desconhecida'}"),
        ],
      ),
    );
  }
}
