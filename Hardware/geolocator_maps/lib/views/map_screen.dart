//mapa com marcação de pontos

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator_maps/controllers/map_controller.dart';
import 'package:geolocator_maps/models/location_points.dart';
import 'package:latlong2/latlong.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  //atributos
  List<LocationPoints> listarPontos = []; //lista com os pontos marcados no map
  final _pointController =  PointController();
  final MapController _flutterMapController = MapController();// obj do controller para executar o método

  bool _isLoading = false;
  String? _erro;

  //método para adicionar o ponto no mapa
  void _adicionarPonto() async {
    setState(() {
      _isLoading = true;
      _erro = null;
    });
    try {
      //pegar a localização atual
      LocationPoints novaMarcacao = await _pointController.getcurrentLocation();
      listarPontos.add(novaMarcacao);
    } catch (e) {
      _erro = e.toString();
      //mostrar o erro
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  //build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //adicionar pontos no Mapa
      //adicionar a biblioteca Flutter_Map(flutter_map)
      appBar: AppBar(
        title: Text("Mapa de Localização"),
        actions: [
          IconButton(
            //evita de apertar o botão seguidamente
            onPressed: _isLoading ? null : _adicionarPonto,
            icon: _isLoading
                ? Padding(
                    padding: EdgeInsets.all(8),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Icon(Icons.add_location_alt),
          ),
        ],
      ),
      body: FlutterMap(
        mapController: _flutterMapController ,
        options: MapOptions(
          initialCenter: LatLng(-23.561684, -46.625378), //Posição Inical SP
          initialZoom: 13
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: "com.example.sa_locator.maps",
          ),
          // proxima camada pontos de MArcação
        ]

        ),
    );
  }
}
