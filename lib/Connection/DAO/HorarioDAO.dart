import 'dart:async';
import 'package:doa_sangue/Model/Horario.dart';
import '../Connection.dart';

class HorarioDAO {
  static Future<Horario> search(Horario horario) async {
    var _db = await Connection.get();
    List<Map> retorno = await _db.query('horario');
    if (retorno.isNotEmpty) {
      return horario.fromMap(retorno.first);
    } else {
      return null!;
    }
  }

  static Future<Horario> searchId(Horario horario) async {
    var _db = await Connection.get();
    List<Map> retorno = await _db.query('horario', where: 'id = ?', whereArgs: [horario.id]);
    if (retorno.isNotEmpty) {
      return horario.fromMap(retorno.first);
    } else {
      return null!;
    }
  }

  static Future<bool> isValidHorario(int id) async {
    var _db = await Connection.get();
    List<Map> retorno = await _db.query('horario', where: 'id = ?', whereArgs: [id]);

    if (retorno.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  static Future insert(Horario horario) async {
    try {
      var _db = await Connection.get();
      await _db.insert('horario', horario.toMap());
      print('Horario cadastrado!');
    } catch (ex) {
      print(ex);
      return;
    }
  }

  static update(Horario horario) async {
    try {
      var _db = await Connection.get();
      await _db.update('horario', horario.toMap(), where: "id = ?", whereArgs: [horario.id]);
    } catch (ex) {
      print(ex);
      return;
    }
  }

  static delete(int id) async {
    try {
      var _db = await Connection.get();
      await _db.delete('horario', where: "id = ?", whereArgs: [id]);
    } on Exception catch (_) {
      print("Erro ao deletar id: "[id]);
      throw Exception("Erro ao deletar id: "[id]);
    }
  }
}
