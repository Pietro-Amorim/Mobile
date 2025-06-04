import 'package:sa_petshop/models/consulta_model.dart';
import 'package:sa_petshop/services/db_help.dart';

class ConsultaController {
  //atributos
  final _dbHelper = DbHelper(); //instância do DBHelper

  //métodos

  // create
  createConsulta(Consulta consulta) async {
    return await _dbHelper.insertConsulta(consulta);
  }

  // readConsultaByPet
  readConsultaByPet(int petId) async {
    return await _dbHelper.getConsultaByPetId(petId);
  }

  // deleteConsulta
  deleteConsulta(int id) async {
    return await _dbHelper.deleteConsulta(id);
  }
}