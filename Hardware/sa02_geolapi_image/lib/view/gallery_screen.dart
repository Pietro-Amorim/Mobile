// lib/view/gallery_screen.dart
import 'package:flutter/material.dart';
import '../controller/photo_controller.dart';
import 'photo_detail_screen.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final PhotoController _controller = PhotoController();

  void _addFromCamera() async {
    await _controller.addPhotoFromCamera();
    setState(() {});
  }

  void _addFromGallery() async {
    await _controller.addPhotoFromGallery();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Minha Galeria")),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "camera",
            onPressed: _addFromCamera,
            child: const Icon(Icons.camera_alt),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "gallery",
            onPressed: _addFromGallery,
            child: const Icon(Icons.photo_library),
          ),
        ],
      ),
      body: _controller.photos.isEmpty
          ? const Center(child: Text("Nenhuma foto registrada"))
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: _controller.photos.length,
              itemBuilder: (context, index) {
                final photo = _controller.photos[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PhotoDetailScreen(photo: photo),
                      ),
                    );
                  },
                  child: Image.file(photo.imageFile, fit: BoxFit.cover),
                );
              },
            ),
    );
  }
}
