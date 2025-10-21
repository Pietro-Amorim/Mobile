class UserModel {
  final String nif;
  final String? name;

  UserModel({required this.nif, this.name});

  // Converte NIF para email (padrão interno)
  String get email => '$nif@empresa.com';
}