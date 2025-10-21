import 'package:geolocator/geolocator.dart';

class LocationController {
  static const double workLat = -23.550522;   // Substitua pelo seu local
  static const double workLng = -46.633309;
  static const int maxDistance = 100; // metros

  Future<Position> getCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) throw Exception('Serviço de localização desativado.');

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission != LocationPermission.whileInUse && 
        permission != LocationPermission.always) {
      throw Exception('Permissão de localização necessária.');
    }

    return await Geolocator.getCurrentPosition();
  }

  double calculateDistance(double lat, double lng) {
    return Geolocator.distanceBetween(lat, lng, workLat, workLng);
  }

  bool isWithinRadius(double distanceMeters) {
    return distanceMeters <= maxDistance;
  }
}