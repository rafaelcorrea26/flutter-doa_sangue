class Doador {
  int id = 0;
  String nome_completo = "";
  String nome_mae = "";
  String nome_pai = "";
  String genero = "";
  String data_nasc = "";
  String cpf = "";
  String rg = "";
  String celular = "";
  String tipo_sangue = "";
  String uf = "";
  String id_carteira_doador = "";
  String email_doador = "";
  String email_solicitante = "";
  String local_internacao = "";
  String motivo = "";
  int qtd_bolsas = 0;
  String imagem = "";

  Doador();

  Map<String, Object> toMap() {
    Map<String, Object> map = {
      'id': id,
      'nome_completo': nome_completo,
      'nome_mae': nome_mae,
      'nome_pai': nome_pai,
      'genero': genero,
      'data_nasc': data_nasc,
      'cpf': cpf,
      'rg': rg,
      'celular': celular,
      'tipo_sangue': tipo_sangue,
      'uf': uf,
      'id_carteira_doador': id_carteira_doador,
      'email_doador': email_doador,
      'email_solicitante': email_solicitante,
      'local_internacao': local_internacao,
      'motivo': motivo,
      'qtd_bolsas': qtd_bolsas,
      'imagem': imagem,
    };
    if (id > 0) {
      map["id"] = id;
    }
    return map;
  }

  fromMap(Map map) {
    id = map['id'];
    nome_completo = map['nome_completo'];
    nome_mae = map['nome_mae'];
    nome_pai = map['nome_pai'];
    genero = map['genero'];
    data_nasc = map['data_nasc'];
    cpf = map['cpf'];
    rg = map['rg'];
    celular = map['celular'];
    tipo_sangue = map['tipo_sangue'];
    uf = map['uf'];
    id_carteira_doador = map['id_carteira_doador'];
    email_doador = map['email_doador'];
    email_solicitante = map['email_solicitante'];
    local_internacao = map['local_internacao'];
    motivo = map['motivo'];
    qtd_bolsas = map['qtd_bolsas'];
    imagem = map['imagem'];
  }

  @override
  String toString() {
    return 'Doador{id: $id, '
        'nome_completo: $nome_completo,'
        'nome_mae: $nome_mae,'
        'nome_pai: $nome_pai,'
        'genero: $genero,'
        'data_nasc: $data_nasc,'
        'cpf: $cpf,'
        'rg: $rg,'
        'celular: $celular,'
        'tipo_sangue: $tipo_sangue,'
        'uf: $uf,'
        'id_carteira_doador: $id_carteira_doador,'
        'email_doador: $email_doador,'
        'email_solicitante: $email_solicitante,'
        'local_internacao: $local_internacao,'
        'motivo: $motivo,'
        'qtd_bolsas: $qtd_bolsas,'
        'imagem: $imagem }';
  }
}
