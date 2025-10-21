import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../controllers/location_controller.dart';
import '../controllers/ponto_controller.dart';
import '../models/registro_ponto.dart';
import 'historico_view.dart';
import 'login_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeView extends StatefulWidget {
  final String usuarioId;

  HomeView({required this.usuarioId});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final AuthController authController = AuthController();
  final LocationController locationController = LocationController();
  final PontoController pontoController = PontoController();

  // Coordenadas fixas do local de trabalho
  final double localLat = -23.5629; // substitua pela latitude real
  final double localLon = -46.6544; // substitua pela longitude real

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Ponto'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await authController.logout();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginView()));
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: registrarPonto,
              child: Text('Registrar Ponto'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => HistoricoView(usuarioId: widget.usuarioId)));
              },
              child: Text('Ver Histórico'),
            ),
          ],
        ),
      ),
    );
  }

  void registrarPonto() async {
    var pos = await locationController.getCurrentLocation();
    if (pos == null) {
      Fluttertoast.showToast(msg: "Não foi possível obter localização");
      return;
    }

    double distancia = locationController.calcularDistancia(pos.latitude, pos.longitude, localLat, localLon);

    if (distancia > 100) {
      Fluttertoast.showToast(msg: "Você está fora da área permitida (${distancia.toStringAsFixed(1)} m)");
      return;
    }

    RegistroPonto registro = RegistroPonto(
      usuarioId: widget.usuarioId,
      dataHora: DateTime.now(),
      latitude: pos.latitude,
      longitude: pos.longitude,
    );

    await pontoController.registrarPonto(registro);
    Fluttertoast.showToast(msg: "Ponto registrado com sucesso!");
  }
}
