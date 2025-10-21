import 'package:flutter/material.dart';
import '../controllers/location_controller.dart';
import '../controllers/point_controller.dart';

class RegisterPointView extends StatefulWidget {
  const RegisterPointView({super.key});

  @override
  State<RegisterPointView> createState() => _RegisterPointViewState();
}

class _RegisterPointViewState extends State<RegisterPointView> {
  final LocationController _locationCtrl = LocationController();
  final PointController _pointCtrl = PointController();
  bool _isLoading = false;
  String _message = '';

  Future<void> _registerPoint() async {
    setState(() {
      _isLoading = true;
      _message = 'Obtendo localização...';
    });

    try {
      final position = await _locationCtrl.getCurrentPosition();
      final distance = _locationCtrl.calculateDistance(position.latitude, position.longitude);

      if (_locationCtrl.isWithinRadius(distance)) {
        await _pointCtrl.registerPoint(
          latitude: position.latitude,
          longitude: position.longitude,
        );
        _message = '✅ Ponto registrado com sucesso!';
      } else {
        _message = '❌ Você está a ${distance.toInt()}m do local. Máximo permitido: 100m.';
      }
    } catch (e) {
      _message = 'Erro: ${e.toString()}';
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar Ponto')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isLoading) const CircularProgressIndicator(),
              if (_message.isNotEmpty) Text(_message),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _registerPoint,
                child: const Text('Registrar Agora'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}