import 'dart:convert';

class Horario {
  int id = 0;
  String data_marcada = "";
  String horario_marcado = "";

  Horario();

  Map<String, Object> toMap() {
    Map<String, Object> map = {
      'data_marcada': data_marcada,
      'horario_marcado': horario_marcado,
    };
    if (id > 0) {
      map["id"] = id;
    }
    return map;
  }

  fromMap(Map map) {
    id = map['id'];
    data_marcada = map['data_marcada'];
    horario_marcado = map['horario_marcado'];
  }

  @override
  String toString() {
    return 'Agendamento{id: $id, '
        'data_marcada: $data_marcada,'
        'horario_marcado: $horario_marcado}';
  }

  String? geraJson() {
    String dados = json.encode(this);
    return dados;
  }
}
