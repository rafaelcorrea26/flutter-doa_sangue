import 'dart:async';
import 'package:doa_sangue/Model/Agendamento.dart';
import '../Connection.dart';

class AgendamentoDAO {
  static Future<Agendamento> search(Agendamento agendamento) async {
    var _db = await Connection.get();
    List<Map> retorno = await _db.query('agendamento');
    if (retorno.isNotEmpty) {
      return agendamento.fromMap(retorno.first);
    } else {
      return null!;
    }
  }

  static Future<Agendamento> searchId(Agendamento agendamento) async {
    var _db = await Connection.get();
    List<Map> retorno = await _db.query('agendamento', where: 'id = ?', whereArgs: [agendamento.id]);
    if (retorno.isNotEmpty) {
      return agendamento.fromMap(retorno.first);
    } else {
      return null!;
    }
  }

  static Future<bool> isValidDoador(int id) async {
    var _db = await Connection.get();
    List<Map> retorno = await _db.query('agendamento', where: 'id = ?', whereArgs: [id]);

    if (retorno.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  static Future<int> returnDoadorId(int id_usuario) async {
    var _db = await Connection.get();
    List<Map> retorno = await _db.query('agendamento', where: 'id_usuario = ?', whereArgs: [id_usuario]);

    if (retorno.isNotEmpty) {
      return retorno[0]["id"];
    } else {
      return 0;
    }
  }

  static Future insert(Agendamento doador) async {
    try {
      var _db = await Connection.get();
      await _db.insert('agendamento', doador.toMap());
      print('Agendamento cadastrado!');
    } catch (ex) {
      print(ex);
      return;
    }
  }

  static update(Agendamento doador) async {
    try {
      var _db = await Connection.get();
      await _db.update('agendamento', doador.toMap(), where: "id = ?", whereArgs: [doador.id]);
    } catch (ex) {
      print(ex);
      return;
    }
  }

  static delete(int id) async {
    try {
      var _db = await Connection.get();
      await _db.delete('agendamento', where: "id = ?", whereArgs: [id]);
    } on Exception catch (_) {
      print("Erro ao deletar id: "[id]);
      throw Exception("Erro ao deletar id: "[id]);
    }
  }
}
