// lib/models/photo_model.dart
import 'dart:io';

class PhotoModel {
  final File imageFile;
  final DateTime dateTime;
  final double? latitude;
  final double? longitude;

  PhotoModel({
    required this.imageFile,
    required this.dateTime,
    this.latitude,
    this.longitude,
  });
}
