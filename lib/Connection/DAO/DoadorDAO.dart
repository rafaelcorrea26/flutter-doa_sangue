import 'dart:async';
import 'package:doa_sangue/Model/Doador.dart';
import '../Connection.dart';

class DoadorDAO {
  static Future<Map> get() async {
    var _db = await Connection.get();
    Map result = Map();
    List<Map> items = await _db.query('doador');

    if (items.isNotEmpty) {
      result = items.first;
    }
    return result;
  }

  static Future<Map> searchId(Doador doador) async {
    var _db = await Connection.get();
    List<Map> items = await _db.query('doador', where: 'id =1'); //?', whereArgs: [doador.id]);

    if (items.isNotEmpty) {
      return doador.fromMap(items.first);
    } else {
      return null!;
    }
  }

  static Future insert(Doador doador) async {
    try {
      var _db = await Connection.get();
      await _db.insert('doador', doador.toMap());
      print('Doador cadastrado!');
    } catch (ex) {
      print(ex);
      return;
    }
  }

  static update(Doador doador) async {
    try {
      var _db = await Connection.get();
      await _db.update(
        'doador',
        doador.toMap(),
      );
    } catch (ex) {
      print(ex);
      return;
    }
  }

  static delete(int id) async {
    try {
      var _db = await Connection.get();
      await _db.delete('doador', where: "id = ?", whereArgs: [id]);
    } on Exception catch (_) {
      print("Erro ao deletar id: "[id]);
      throw Exception("Erro ao deletar id: "[id]);
    }
  }
}
