class RegistroPonto {
  String usuarioId;
  DateTime dataHora;
  double latitude;
  double longitude;

  RegistroPonto({
    required this.usuarioId,
    required this.dataHora,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'usuarioId': usuarioId,
      'dataHora': dataHora.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
