// lib/controller/photo_controller.dart
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import '../models/photo_model.dart';

class PhotoController {
  final List<PhotoModel> _photos = [];
  final ImagePicker _picker = ImagePicker();

  List<PhotoModel> get photos => _photos;

  Future<void> addPhotoFromCamera() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      final position = await _getCurrentPosition();
      _photos.add(PhotoModel(
        imageFile: File(photo.path),
        dateTime: DateTime.now(),
        latitude: position?.latitude,
        longitude: position?.longitude,
      ));
    }
  }

  Future<void> addPhotoFromGallery() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      final position = await _getCurrentPosition();
      _photos.add(PhotoModel(
        imageFile: File(photo.path),
        dateTime: DateTime.now(),
        latitude: position?.latitude,
        longitude: position?.longitude,
      ));
    }
  }

  Future<Position?> _getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return null;
    }
    if (permission == LocationPermission.deniedForever) return null;

    return await Geolocator.getCurrentPosition();
  }
}
